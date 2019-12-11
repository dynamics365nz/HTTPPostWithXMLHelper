codeunit 50101 "HTTP Post with XML Helper"
{
    procedure SaveXMLMessage(var YourIntegrationLog: Record "Integration Log"): Boolean
    var
        XMLExport: XmlPort "Export XML Test";
        MyOutStream: OutStream;

    begin
        FileName := 'Test1.XML';
        YourIntegrationLog."XML File BLOB".CreateOutStream(MyOutStream, TextEncoding::UTF8);
        XMLExport.SetDocumentFilters(YourIntegrationLog."Document No.");
        XMLExport.SetDestination(MyOutStream);
        XMLExport.Filename(FileName);
        IF XMLExport.Export() then;

    end;

    local procedure ReadXML2Text(Var YourIntegrationLog: Record "Integration Log") ReturnValue: Text
    var
        InStr: InStream;
        Line: text;
    begin
        if not YourIntegrationLog."XML File BLOB".HasValue() Then
            exit;
        YourIntegrationLog.CALCFIELDS("XML File BLOB");
        YourIntegrationLog."XML File BLOB".CreateInStream(InStr);
        InStr.ReadText(ReturnValue);

        while not InStr.EOS() do begin
            InStr.ReadText(Line);
            ReturnValue += Line;
        end;
    end;

    var
        FileName: Text;

}