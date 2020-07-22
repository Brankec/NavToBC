table 38024257 "Redak inozemstva"
{
    DrillDownPageID = 60111;
    LookupPageID = 60111;

    fields
    {
        field(1; "Broj Isplate"; Code[20])
        {
        }
        field(2; "Datum isplate"; Date)
        {
        }
        field(3; "Godina za koju se vrši obrada"; Text[4])
        {
        }
        field(4; "Mjesec za koji se vrši obrada"; Integer)
        {
        }
        field(5; "Identifikator R-S obrasca"; Code[20])
        {
        }
        field(6; "Vrsta uplate R-S"; Code[20])
        {
        }
        field(7; "Vrsta obveznika R-S"; Code[20])
        {
        }
        field(8; "Broj Ugovora"; Code[20])
        {
            TableRelation = "Ugovori UOD".Broj;

            trigger OnValidate()
            begin
                if "Broj Ugovora" <> xRec."Broj Ugovora" then begin
                    if RecUgovori.GET("Broj Ugovora") then begin
                        "Izvršitelj Broj" := RecUgovori."Izvršitelj Broj";
                    end else begin
                        "Izvršitelj Broj" := '';
                        "Employee ID" := '';
                        Ime := '';
                        Prezime := '';
                        "Šifra općine" := '';
                    end;
                    if "Izvršitelj Broj" <> '' then
                        if Employee.GET("Izvršitelj Broj") then begin
                            "Employee ID" := Employee."Employee ID";
                            Ime := Employee."First Name";
                            Prezime := Employee."Last Name";
                            "Šifra općine" := Employee."Šifra općine";
                        end;
                end;
            end;
        }
        field(9; "Izvršitelj Broj"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Izvršitelj Broj" <> xRec."Izvršitelj Broj" then begin
                    if Employee.GET("Izvršitelj Broj") then begin
                        "Employee ID" := Employee."Employee ID";
                        Ime := Employee."First Name";
                        Prezime := Employee."Last Name";
                        "Šifra općine" := Employee."Šifra općine";
                    end else begin
                        "Employee ID" := '';
                        Ime := '';
                        Prezime := '';
                        "Šifra općine" := '';
                    end;
                end;
            end;
        }
        field(10; "Employee ID"; Code[13])
        {
            Caption = 'Employee ID';
        }
        field(11; Ime; Text[30])
        {
        }
        field(12; Prezime; Text[30])
        {
        }
        field(13; "Šifra općine"; Code[20])
        {
            TableRelation = Table60020;
        }
        field(14; Osnovica; Decimal)
        {
        }
        field(15; "Postotak doprinosa"; Decimal)
        {
        }
        field(16; "Dnevna osnovica"; Decimal)
        {
        }
        field(17; "Dnevna obveza"; Decimal)
        {
        }
        field(18; "Od dana"; Integer)
        {
        }
        field(19; "Do dana"; Integer)
        {
        }
        field(20; "Broj dana na putu"; Decimal)
        {
        }
        field(21; "Iznos doprinosa"; Decimal)
        {
        }
        field(22; "Iznos osnovice za doprinos"; Decimal)
        {
        }
        field(23; "Djelatnik broj"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if "Djelatnik broj" <> xRec."Djelatnik broj" then begin
                    if recDjelatnik.GET("Djelatnik broj") then begin
                        "Employee ID" := recDjelatnik."Employee ID1";
                        Ime := recDjelatnik."First Name";
                        Prezime := recDjelatnik."Last Name";
                        //    "Šifra općine" := recdjelatnik."Šifra općine"; //???????????????
                    end else begin
                        "Employee ID" := '';
                        Ime := '';
                        Prezime := '';
                        "Šifra općine" := '';
                    end;
                end;
            end;
        }
        field(88; "Faza rada"; Option)
        {
            Description = 'Obrada,Zaključivanje';
            OptionMembers = Obrada,"Zaključivanje";
        }
        field(60100; Redak; Integer)
        {
            AutoIncrement = false;
        }
    }

    keys
    {
        key(Key1; "Broj Isplate", Redak)
        {
            Clustered = true;
        }
        key(Key2; "Employee ID", "Godina za koju se vrši obrada")
        {
        }
        key(Key3; "Identifikator R-S obrasca", "Izvršitelj Broj")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Faza rada" = "Faza rada"::"Zaključivanje" then
            ERROR(msg001);
    end;

    trigger OnInsert()
    begin
        if "Faza rada" = "Faza rada"::"Zaključivanje" then
            ERROR(msg001);
    end;

    trigger OnModify()
    begin
        if "Faza rada" = "Faza rada"::"Zaključivanje" then
            ERROR(msg001);
    end;

    trigger OnRename()
    begin
        if "Faza rada" = "Faza rada"::"Zaključivanje" then
            ERROR(msg001);
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        Employee: Record "Poslovni partner UOD";
        Res: Record Resource;
        PostCode: Record "Post Code";
        AlternativeAddr: Record "Alternative Address";
        EmployeeQualification: Record "Employee Qualification";
        Relative: Record "Employee Relative";
        EmployeeAbsence: Record "Employee Absence";
        MiscArticleInformation: Record "Misc. Article Information";
        ConfidentialInformation: Record "Confidential Information";
        HumanResComment: Record "Human Resource Comment Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        Modul11: Integer;
        Text000: ;
        Text001: ;
        Text002: ;
        RecUgovori: Record "Ugovori UOD";
        recDjelatnik: Record Employee;
        msg001: Label 'Nisu moguće promjene u zaključenoj isplati!';
}

