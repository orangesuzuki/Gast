function trace(a){
//  Logger.log(a);
}

function getSheetData(sheetId, sheetName)
{
  var sheet = SpreadsheetApp.openById(sheetId).getSheetByName(sheetName);
  if(!sheet)
    return false;
  var sheetData  = sheet.getDataRange().getValues();
  return [sheet, sheetData];
}

/**
 * データの取得
 */
function getLine(sheetId, sheetName, row){
  var sheetInfo = getSheetData(sheetId, sheetName);
  var sheet = sheetInfo[0];
  var sheetData = sheetInfo[1];
  
  if(row==-1)
    row = sheetData.length-1;
  return getLineFromSheetData(sheetData, row);
}

function getLineFromSheetData(sheetData, row){
  var columnNum = sheetData.length;
  
  // 項目名の配列
  var rowNames = sheetData[0];
  var dataSet = sheetData[row];
  
  var obj = {};
  for(var i=0; i < rowNames.length; i++){
    obj[rowNames[i]] = dataSet[i];
  }
  var json = JSON.stringify(obj);
  return json;
}

function outputText(result){
  return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.TEXT);
}