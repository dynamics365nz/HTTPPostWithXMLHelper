Table 50101 "Integration Log"
{
    DataClassification = CustomerContent;
    Caption = 'Integration Log';

    fields
    {
        field(10; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
 
        field(20; "XML File BLOB"; Blob)
        {
            DataClassification = CustomerContent;
        }

        Field(30; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

}

