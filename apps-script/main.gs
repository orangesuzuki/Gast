// �V�[�gID
var sheetId = "";
// ����^�C�v
var ACTION_TYPE_APPEND = "append";
var ACTION_TYPE_FETCH = "fetch";

function doGet(req) {
  var result = reveiveHandler(req, "GET");
  //var result = "hoge" + Utilities.formatDate(new Date(), "JST", "yyyy/MM/dd-HH:mm:ss");
  return output(result);
}

function doPost(req){
  var result = reveiveHandler(req, "POST");
  //var result = "hoge" + Utilities.formatDate(new Date(), "JST", "yyyy/MM/dd-HH:mm:ss");
  return output(result);
}

function debug(){
  var req = {
    parameter:{
      sheetName : "s0",
//      action : ACTION_TYPE_APPEND,
      action : ACTION_TYPE_FETCH,
      actionParam : 10,
      
      saveData : JSON.stringify({
        browser:"chrome",
        OS:"windows 7",
        flashplayer:"16",
        game1:"hogehoge",
        game2:"fwefwf"
      })
    }
  };  
  reveiveHandler(req);
}

function reveiveHandler(req, option){
  if(req){
    var sheetName = req.parameter.sheetName;
    var dataSet = req.parameter.saveData;
    var action = req.parameter.action;
    var row = req.parameter.actionParam;
    
    if(action==ACTION_TYPE_APPEND)
      return addData(sheetId, sheetName, dataSet);
    else if(action==ACTION_TYPE_FETCH)
      return getLine(sheetId, sheetName, row);
    else
      return "ERROR : req but no action. "+option;
  }
  else{
    return "no req. "+option;
  }
}

/**
 * �f�[�^�̒ǉ�
 */
function addData(sheetId, sheetName, dataSet){
  var sheetInfo = getSheetData(sheetId, sheetName);
  var sheet = sheetInfo[0];
  var sheetData = sheetInfo[1];
  var columnNum = sheetData.length;

  // ���M�f�[�^�̓W�J
  dataSet = JSON.parse(dataSet);
  // ���̑��̃f�[�^�̒ǉ�
  dataSet.id = sheetData.length;//�s��
  dataSet.date = Utilities.formatDate(new Date(), "JST", "yyyy/MM/dd-HH:mm:ss");
  // ���ږ��̔z��
  var rowNames = sheetData[0];
  
  // �ǉ�����f�[�^�̍쐬
  var _data = [];
  for(var i=0; i < rowNames.length; i++){ 
    var hit = false;
    for (var key in dataSet){   
      if(rowNames[i]==key){
        trace("key " + key);  
        _data.push(dataSet[key]);
        hit = true;
      }
    }
    if(!hit)
      _data.push("none");
  }
  // �f�[�^�}��
  sheet.appendRow(_data);
  
  // �Ō�̍s��Ԃ�
  var json = JSON.stringify({
    status:1,
    results: getLine(sheetId, sheetName, -1)
  });
  return json;
}

function output(result){
  return outputText(result);
}