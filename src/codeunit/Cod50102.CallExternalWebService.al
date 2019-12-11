codeunit 50102 "Call External WS"
{

    procedure SendMessage(var YourIntegrationLog: Record "Integration Log"; var ResponseInText: Text; XMLInText: text; PushHttpAddress: Text[80]; UserName: text[30]) lSuccess: Boolean
    var
        uri: Text;
        RequestHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        RequestContent: HttpContent;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        text2Send: Text;
    begin
        content.Clear();
        HttpClient.Clear();
        RequestHeaders.Clear();
        RequestMessage.Content().Clear();
        ResponseMessage.Content().Clear();
        ResponseMessage.Headers().Clear();

        lSuccess := False;
        //Init parameters

        uri := pushHttpAddress;

        RequestMessage.SetRequestUri(uri);
        RequestMessage.Method := 'POST';

        text2Send := XMLInText;
        RequestContent.writefrom(Text2Send);
        RequestContent.GetHeaders(RequestHeaders);
        RequestHeaders.Remove('Content-Type');
        RequestHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');
        RequestMessage.Content := RequestContent;

        //add auth details
        AddHttpBasicAuthHeader(UserName, GetPassword(), HttpClient);
        //Send Http Request
        IF HttpClient.Send(RequestMessage, ResponseMessage) then;

        //Retrieve Response
        Content := ResponseMessage.Content();
        Content.ReadAs(ResponseInText);
        lSuccess := ResponseMessage.IsSuccessStatusCode();
    end;

    local procedure GetPassword(): Text;
    var
        Pwd: Text;
        storageKey: Text;
    begin
        storageKey := GetStorageKey();
        if IsolatedStorage.Contains(storageKey, DataScope::Module) then begin
            IsolatedStorage.Get(storageKey, DataScope::Module, Pwd);
            exit(Pwd);
        end;
    end;

    local procedure GetStorageKey() ReturnValue: Text
    var
        StorageKeyTxt: Label 'Your-Storage-GUID-Here', Locked = true;
    begin
        ReturnValue := StorageKeyTxt;
    end;

    procedure AddHttpBasicAuthHeader(UserName: Text[50]; Password: Text[50]; var HttpClient: HttpClient);
    var
        TypeHelper: codeunit "Base64 Convert";
        AuthString: Text;
    begin
        AuthString := STRSUBSTNO('%1:%2', UserName, Password);
        AuthString := TypeHelper.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    end;
}