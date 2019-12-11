XmlPort 50101 "Export XML Test"
{
    Encoding = UTF8;
    Direction = Export;

    schema
    {
        textelement(Test1)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            XmlName = 'Test1';
        }
    }

    var
    gDocNo :Code[20];

    procedure SetDocumentFilters(lDocNo: Code[20])
    begin
        gDocNo := lDocNo;
    end;
}

