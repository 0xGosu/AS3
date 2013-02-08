package {
    /**
	 * ...
	 * @author V.Anh Tran
	 */


import flash.display.Graphics;
import flash.errors.*;
import flash.events.*;
import flash.net.Socket;
import graph.Paint;
import mathematic.Vector2D;
import flash.system.Security;
class SocketTest extends Socket {
    private var response:String;
	public var graph:Graphics;
	private var HOST:String;
	private var PORT:uint;
    public function SocketTest(host:String = null, port:uint = 0) {
        super();
        configureListeners();
		//Security.allowDomain("*");
		//Security.allowInsecureDomain("*");
		//Security.loadPolicyFile("https://dl.dropbox.com/u/15830149/flashpolicy.xml");
		//Security.loadPolicyFile("192.168.1.10:8020");
        if (host && port)  {
            HOST = host;
			PORT = port;
			//timeout = 1000;
			
			super.connect(host, port);
        }
    }

    private function configureListeners():void {
        addEventListener(Event.CLOSE, closeHandler);
        addEventListener(Event.CONNECT, connectHandler);
        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
    }

    private function writeln(str:String):void {
        str += "\n";
        try {
            writeUTFBytes(str);
        }
        catch(e:IOError) {
            trace(e);
        }
    }

    private function sendRequest():void {
        trace("sendRequest");
        response = "";
        writeln("GET /");
        flush();
    }

    private function readResponse():void {
        var str:String = readUTFBytes(bytesAvailable);
        trace("response:" + str);
		try{
			var jsonData = JSON.parse(str);
			//trace("length=" + jsonData.length);
			var lineArray:Array = new Array();
			for (var i:int = 0; i < jsonData.length;i++) {
				var s:String = jsonData[i];
				//trace(s);
				var ar:Array = s.split(',');
				//trace(ar[0] + '|' + ar[1]);
				var p= new Vector2D(Number(ar[0]),Number(ar[1]));
				lineArray.push(p);
				//trace(p);
			}
			trace("number of point in Line:" + lineArray.length);
			if(graph)Paint.drawLine(graph, lineArray, 6, 0);
		}catch (errObject:Error) {
			trace(errObject);
		}
		
		response += str;
    }

    private function closeHandler(event:Event):void {
        trace("closeHandler: " + event);
        trace(response.toString());
    }

    private function connectHandler(event:Event):void {
        trace("connectHandler: " + event);
        //sendRequest();
		writeln("I am Flash Client");
        flush();
		if (graph) { 
			//graph.clear();
			Paint.roundRect(graph, 0, 0, 320 , 480, 9,0,true,0x00FFFF);
		}
    }

    private function ioErrorHandler(event:IOErrorEvent):void {
        trace("ioErrorHandler: " + event);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void {
        trace("securityErrorHandler: " + event);
		/*get to next ip
		var ar:Array = HOST.split('.');
		var last:int = ar[ar.length - 1];
		if(last >= 255)return;
		last++;ar[ar.length - 1] = new String(last);
		HOST=ar.join('.');
		super.connect(HOST, PORT)*/;
    }

    private function socketDataHandler(event:ProgressEvent):void {
        trace("socketDataHandler: " + event);
        readResponse();
    }
}

}
