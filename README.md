# Gast
Google SpreadSheet tools for ActionScript 3.0.  
You can fetch or append the data from swf to your spreadsheet.

### *Features
* fetch the data from your sheet.
* write some data to your sheet.
* auto add some user information like a display size, Browser, OS, Memory size, etc.

### *Usage
    // 1. Setup
    Gast.initialize( sheetUrl, sheetName );
    
    // 2. Append the data
    Gast.send(new GastData(
    {
        game0: Math.random() * 100000,
        game1: "abc",
        game2: JSON.stringify({param0: 1, param1: 100, param2: -123, param3: 0.568}),
        stageW: stage.stageWidth,
        stageH: stage.stageHeight
    }
    ))
    .done(function(result:String):void {
        log(result);
    })
    .fail(function(result:String):void {
        log(result);
    });
    
    // 3. Fetch the data
    Gast.fetch(row)
    .done(function(result:String):void {
        log(result);
    })
    .fail(function(result:String):void {
        log(result);
    });
