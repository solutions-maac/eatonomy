import '../../Network/api_client.dart';

class HomeRepository{
  final ApiClient apiClient;
  HomeRepository({required this.apiClient});


 Future getCheck()async{
    apiClient.getData(uri: "target/last-sevenday-data");
    // apiClient.getData(uri: "target/last-sevenday-data",headers: {"xxx":"xxxx"});
  }
}