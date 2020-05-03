import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:sss_mobile/models/vehicle.dart';

import 'env.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {
      data.headers["Authorization"] = "Bearer hgzp_v9l81L8XdvwT2vIsAZq23Gh7lRUm3au2CCa2a-bskBUvlV3r0UGGK2Qu-wEOxBWO6xr07iJ7q2Bkz31ny9logvqhet09w1pUh6d1VQi2I7mk5nw3WElcX91IlnnmQu42ZKwKMPRJo2yiDlZZtlCp6Y7CTKvm2WuFSmHjCgueWX9vReiCqJ4M_HPXT3xzVS7QFdOBaykiP6T2b5AnMDNL82_LR4gWPfBDTmzusLCRTxS2t_3uWjRllKyCbmmd30kdRfPWvoD8-RGwfK3wog4rcvX4D9K1f7HZD1bNeAE-Uztw3v-YjdzCtIeVhDkwgrr9qv_qNUXDKEtzIErJsgdowt0ftcbj8EqADHUeFEVtNrX1LWJVAFEfG-itYXWz8--84TP9y-smz3-zk6QiaeNPJ_TbAV_e2SI-Mm06fuiwPPgHr5_WwohGZnxw25mqz3FJPsZg25gVRZVZ_NyPFyxHg65glYCGYUKI7iqFlGDnITLjxVBpPgr8T4mSY1ugxpI-mt3YTVl6OaoRCxAWTvJNo86xaLO3erKk_sE3Ci47LxKpRyde3kuLBp6_UqxXhA1axOTLY6kXthy3RuCG5dubKTd6xxvaITYNcpk08POM0IftdDDefcR8J3gi2bRTeG1jHgR34BvtJLWnRJiKS0WsSIa6hoxmDdsAWYXO0o5DKCcl_QD4NRuxScdMhC70m8AnkkIsC_hc1UvPWlrJmae2g3clMMd_nNja031bi_-dKEbegiFHMuSgimBiKncp_0F1Y53rCtv_33DLzj6CoVQznh-vIFSds_zViIp8C7F8Jvdse5CSxGI-szdSiTobpjuWVoF5wBibOU1LV1V2n2276dm9cLkQa3QFEJnPJ83JvjwTA-tAXVM7MvuDld_yfUr0oaOBRJzdK4OhOrTJToiJClmlIgYvXIhLgNLX9pAZQ2tBmVBPnZLDX9n_o4rwH_u77_eFg7hsz1G3ofb9HlrR-PNPB0_PsjRX2kxmcn2h8K07YINQvBzpt3B1UDLuUWf466baKtuVqCtMuBTbgOO3-aMyGu8L8nMEg6--kh5xHtIUttwU_I0gdjCgUlioT6aVnQo62l8yLzsXEsAvNhTzanQSMMBtfvkOT67anQz8w7N8emdsQNQVRo-dYEXrLHWZj8LFDn_Q_bhjAPgVRT0CIeMYOHJteRnIet6xYwEqHjwleBTYFxhUng5pitjo39QBVX7JqtruD-P8Qy-EOGMBs_C-1bDrLqz5KYKQ9AY8jAq0qXMvKO1BIB2uKpXkK-FE0mK6rP24T7VgC2V-W_ijf61Edpj4ULd15bPJ4jSdzK0_TLhfLCDmyfrlgKX_84N_ec1LVvKA8LyUjVXrpR4GyOsSyqJ918VyLz4WT0IP1uFz7dySZ6MclnhGOZXRcl_NF2ZDXifs2DSdsRTSOVqO0jx0rZ3aOHywF5_0BWftfMg9bcbGKrT3Q59gHJi";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}

class VehicleFactory {
  Client client = HttpClientWithInterceptor.build(interceptors: [
    AuthInterceptor(),
  ]);
  
  Future<List<Vehicle>> fetchVehicles() async {
    var vehicles = <Vehicle>[];
    try {
      final response = await client.get("${environment['baseUrl']}/vehicles");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (var j in json) {
          vehicles.add(Vehicle.fromJson(j));
        }
      } else {
        throw Exception("Error while fetching. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return vehicles;
  }
}