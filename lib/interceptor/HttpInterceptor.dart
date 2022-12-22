import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:localstorage/localstorage.dart';

import '../consts/constant.dart';

class HttpInterceptor implements InterceptorContract {
  final LocalStorage storage = LocalStorage(Constant.localStorageKey);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if(storage.getItem('token') != null) {
      data.headers.putIfAbsent(
          'Authorization', () => "Bearer ${storage.getItem('token')}");
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
