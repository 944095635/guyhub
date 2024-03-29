import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:guyhub/model/extension.dart';
import 'package:guyhub/util/extension.dart';
import 'package:guyhub/util/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

/// 扩展服务
class ExtensionService {
  /// 运行服务
  static JavascriptRuntime? _runtime;

  /// 启动一个插件脚本
  static Future run(Extension extension) async {
    _runtime = getJavascriptRuntime();

    // 读取扩展包内容
    String? extScript = await ExtensionUtils.loadExtension(extension.package);
    if (extScript?.isNotEmpty == true) {
      final cryptoJs = await rootBundle.loadString('assets/js/CryptoJS.min.js');
      final jsencrypt =
          await rootBundle.loadString('assets/js/jsencrypt.min.js');
      final md5 = await rootBundle.loadString('assets/js/md5.min.js');
      _runtime!.evaluate('''
          // 重写 console.log
          var window = (global = globalThis);
          $cryptoJs
          $jsencrypt
          $md5
          class Element {
            constructor(content, selector) {
              this.content = content;
              this.selector = selector || "";
            }

            async querySelector(selector) {
              return new Element(await this.excute(), selector);
            }

            async excute(fun) {
              return await sendMessage(
                "querySelector",
                JSON.stringify([this.content, this.selector, fun])
              );
            }

            async removeSelector(selector) {
              this.content = await sendMessage(
                "removeSelector",
                JSON.stringify([await this.outerHTML, selector])
              );
              return this;
            }

            async getAttributeText(attr) {
              return await sendMessage(
                "getAttributeText",
                JSON.stringify([await this.outerHTML, this.selector, attr])
              );
            }

            get text() {
              return this.excute("text");
            }

            get outerHTML() {
              return this.excute("outerHTML");
            }

            get innerHTML() {
              return this.excute("innerHTML");
            }
          }
          class XPathNode {
            constructor(content, selector) {
              this.content = content;
              this.selector = selector;
            }

            async excute(fun) {
              return await sendMessage(
                "queryXPath",
                JSON.stringify([this.content, this.selector, fun])
              );
            }

            get attr() {
              return this.excute("attr");
            }

            get attrs() {
              return this.excute("attrs");
            }

            get text() {
              return this.excute("text");
            }
            
            get allHTML() {
              return this.excute("allHTML");
            }

            get outerHTML() {
              return this.excute("outerHTML");
            }
          }

          
          console.log = function (message) {
            if (typeof message === "object") {
              message = JSON.stringify(message);
            }
            sendMessage("log", JSON.stringify([message.toString()]));
          };
          class Extension {
            package = "${extension.package}";
            name = "${extension.name}";
            // 在 load 中注册的 keys
            settingKeys = [];
            async request(url, options) {
              options = options || {};
              options.headers = options.headers || {};
              const miruUrl = options.headers["Miru-Url"] || "${extension.webSite}";
              options.method = options.method || "get";
              const res = await sendMessage(
                "request",
                JSON.stringify([miruUrl + url, options])
              );
              try {
                return JSON.parse(res);
              } catch (e) {
                return res;
              }
            }
            querySelector(content, selector) {
              return new Element(content, selector);
            }
            queryXPath(content, selector) {
              return new XPathNode(content, selector);
            }
            async querySelectorAll(content, selector) {
              let elements = [];
              JSON.parse(
                await sendMessage("querySelectorAll", JSON.stringify([content, selector]))
              ).forEach((e) => {
                elements.push(new Element(e, selector));
              });
              return elements;
            }
            async getAttributeText(content, selector, attr) {
              return await sendMessage(
                "getAttributeText",
                JSON.stringify([content, selector, attr])
              );
            }
            popular(page) {
              throw new Error("not implement popular");
            }
            latest(page) {
              throw new Error("not implement latest");
            }
            search(kw, page, filter) {
              throw new Error("not implement search");
            }
            createFilter(filter){
              throw new Error("not implement createFilter");
            }
            detail(url) {
              throw new Error("not implement detail");
            }
            watch(url) {
              throw new Error("not implement watch");
            }
            checkUpdate(url) {
              throw new Error("not implement checkUpdate");
            }
            async getSetting(key) {
              return sendMessage("getSetting", JSON.stringify([key]));
            }
            async registerSetting(settings) {
              console.log(JSON.stringify([settings]));
              this.settingKeys.push(settings.key);
              return sendMessage("registerSetting", JSON.stringify([settings]));
            }
            async load() {}
          }

          async function stringify(callback) {
            const data = await callback();
            return typeof data === "object" ? JSON.stringify(data,0,2) : data;
          }

    ''');

      final ext = extScript!.replaceAll(
          RegExp(r'export default class.*'), 'class Ext extends Extension {');

      JsEvalResult jsResult = await _runtime!.evaluateAsync('''
      $ext
      var extension = new Ext();
      extension.load().then(()=>{
        sendMessage("cleanSettings", JSON.stringify([extension.settingKeys]));
      });
    ''');
      await _runtime!.handlePromise(jsResult);

      /// 注册一些回调事件
      // 请求
      _runtime!.onMessage('request', (dynamic args) async {
        //String _cuurentRequestUrl = args[0];
        final headers = args[1]['headers'] ?? {};
        if (headers['User-Agent'] == null) {
          headers['User-Agent'] = "";
        }

        final url = args[0];
        //final method = args[1]['method'] ?? 'get';
        //final requestBody = args[1]['data'];
        //queryParameters: args[1]['queryParameters'] ?? {},
        var result = await Http.get(url);
        return result.data;
      });

      // css 选择器
      _runtime!.onMessage('querySelector', (dynamic args) {
        final content = args[0];
        final selector = args[1];
        final fun = args[2];

        final doc = parse(content).querySelector(selector);

        switch (fun) {
          case 'text':
            return doc?.text ?? '';
          case 'outerHTML':
            return doc?.outerHtml ?? '';
          case 'innerHTML':
            return doc?.innerHtml ?? '';
          default:
            return doc?.outerHtml ?? '';
        }
      });

      // xpath 选择器
      _runtime!.onMessage('queryXPath', (args) {
        final content = args[0];
        final selector = args[1];
        final fun = args[2];

        final xpath = HtmlXPath.html(content);
        final result = xpath.queryXPath(selector);

        switch (fun) {
          case 'attr':
            return result.attr ?? '';
          case 'attrs':
            return jsonEncode(result.attrs);
          case 'text':
            return result.node?.text;
          case 'allHTML':
            return result.nodes
                .map((e) => (e.node as Element).outerHtml)
                .toList();
          case 'outerHTML':
            return (result.node?.node as Element).outerHtml;
          default:
            return result.node?.text;
        }
      });

      _runtime!.onMessage('removeSelector', (dynamic args) {
        final content = args[0];
        final selector = args[1];
        final doc = parse(content);
        doc.querySelectorAll(selector).forEach((element) {
          element.remove();
        });
        return doc.outerHtml;
      });

      // 获取标签属性
      _runtime!.onMessage('getAttributeText', (args) {
        final content = args[0];
        final selector = args[1];
        final attr = args[2];
        final doc = parse(content).querySelector(selector);
        return doc?.attributes[attr];
      });

      _runtime!.onMessage('querySelectorAll', (dynamic args) async {
        final content = args[0];
        final selector = args[1];
        final doc = parse(content).querySelectorAll(selector);
        final elements = jsonEncode(doc.map((e) {
          return e.outerHtml;
        }).toList());

        return elements;
      });
    }
  }

  /// 停止一个脚本
  static stop() {
    _runtime?.dispose();
    _runtime = null;
  }

  /// 加载数据 - 列表项目
  static Future<List<ExtensionListItem>> loadData(int pageIndex) async {
    final JsEvalResult jsResult = await _runtime!.handlePromise(
      await _runtime!
          .evaluateAsync('stringify(()=>extension.latest($pageIndex))'),
    );
    var jsonStr = jsResult.stringResult;
    List list = json.decode(jsonStr);
    List<ExtensionListItem> data = [];
    for (var element in list) {
      var item = ExtensionListItem.fromJson(element);
      data.add(item);
    }
    return data;
  }

  /// 读取资源详情
  static Future<ExtensionDetail> loadDetail(ExtensionListItem ext) async {
    final jsResult = await _runtime!.handlePromise(
      await _runtime!
          .evaluateAsync('stringify(()=>extension.detail("${ext.url}"))'),
    );
    final result = ExtensionDetail.fromJson(jsonDecode(jsResult.stringResult));
    //result.headers ??= await _defaultHeaders;
    return result;
  }

  /// 读取播放信息，阅读，观看信息
  static Future<dynamic> loadPlay(String url) async {
    final jsResult = await _runtime!.handlePromise(
      await _runtime!.evaluateAsync('stringify(()=>extension.watch("$url"))'),
    );
    final data = jsonDecode(jsResult.stringResult);
    return data;
  }
}
