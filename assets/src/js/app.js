/// receives Data From WebView Mobile Application
window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
             window.flutter_inappwebview.callHandler('onLoadData').then(function(result) {
             console.log("onLoadData Ready To Call");
//               console.log(result);
               console.log(JSON.stringify(result));
               setUp(result);
             });
           });
function setUp(dataSet) {
  console.log("Coming");
  // Retrieve Data
  let key = dataSet["key"];
  let txnid = dataSet["txnid"];
  let amount = dataSet["amount"];
  let productinfo = dataSet["productinfo"];
  let firstname = dataSet["firstname"];
  let email = dataSet["email"];
  let phone = dataSet["phone"];
  let curl = dataSet["curl"];
  let furl = dataSet["furl"];
  let surl = dataSet["surl"];
  let hash = dataSet["hash"];
  let postsubmiturl = dataSet["postsubmiturl"];
  let udf1 = dataSet["udf1"];
  let udf2 = dataSet["udf2"];

  // let hash = "f5e61b67ed46e8f86ca18a15ca8019c59f81a23d73cf7cc3f9166a58bac717e72e491983f2874818404d8b4d12ed53aee16f5cc7b43385512285633f8e1e8c54"

//  Print.postMessage(dataSet["postsubmiturl"]);
  console.log(dataSet["postsubmiturl"]);

  // Setup
  $("#key").val(key);
  $("#txnid").val(txnid);
  $("#amount").val(amount);
  $("#productinfo").val(productinfo);
  $("#firstname").val(firstname);
  $("#email").val(email);
  $("#phone").val(phone);
  $("#curl").val(curl);
  $("#furl").val(furl);
  $("#surl").val(surl);
  $("#hash").val(hash);
  $("#postsubmiturl").val(postsubmiturl);
  $("#udf1").val(udf1);
  $("#udf2").val(udf2);
  $("#form").attr("action", postsubmiturl);
  $("#form").submit();
}
