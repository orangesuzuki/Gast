/**
 * データの追加テスト
 */
function appendTest(){
  var req = {
    parameter:{
      sheetName : "s0",
      action : ACTION_TYPE_APPEND,
      actionParam : 0,      
      saveData : JSON.stringify({
        browser:"chrome",
        OS:"windows 7",
        flashplayer:"16",
        game1:"Mamma Mia!",
        game2: Math.round(1000*Math.random()),
        game3: 500+Math.round(300*Math.random())
      })
    }
  };  
  reveiveHandler(req);
}

/**
 * データの取得テスト
 */
function fetchTest(){
    var req = {
    parameter:{
      sheetName : "s0",
      action : ACTION_TYPE_FETCH,
      actionParam : 1
    }
  };
  var result = reveiveHandler(req);
  Logger.log(result);
}