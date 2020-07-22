table 38024260 "Redak Knjižene Isplate"
{
    // 051230 - mmatko - Dodao ključ "Broj Isplate", "Izvršitelj puno Ime" za ispis analitičkih kartica po abecedi
    // 060315 - mmatko - Dodao polja za stipendije


    fields
    {
        field(1; "Broj Isplate"; Code[20])
        {
            Caption = 'Broj Isplate';
        }
        field(2; "Vrsta ugovora za obradu"; Option)
        {
            Caption = 'Vrsta ugovora za obradu';
            Description = 'Ugovori o djelu,Isplate članovima nadzornih odbora,Autorski honorari,Stipendije';
            OptionMembers = "Ugovori o djelu","Isplate članovima nadzornih odbora","Autorski honorari",Stipendije;
        }
        field(3; "Datum isplate"; Date)
        {
            Caption = 'Datum isplate';
        }
        field(4; "Godina za koju se vrši obrada"; Text[4])
        {
            Caption = 'Godina obrade';
        }
        field(5; "Mjesec za koji se vrši obrada"; Integer)
        {
            Caption = 'Mjesec obrade';
        }
        field(6; "Identifikator R-S obrasca"; Code[20])
        {
            Caption = 'Identifikator R-S obrasca';
            TableRelation = "R-S obrazac A strana"."Identifikator obrasca";
        }
        field(7; "Faza rada"; Option)
        {
            Caption = 'Faza rada';
            Description = 'Otvaranje,Generiranje,Kontrola,Obračun,Zaključivanje';
            OptionMembers = Otvaranje,Generiranje,Kontrola,"Obračun","Zaključivanje";
        }
        field(8; "Broj Ugovora"; Code[20])
        {
            Caption = 'Broj Ugovora';
        }
        field(9; "Vrsta ugovora"; Code[20])
        {
            Caption = 'Vrsta ugovora';
            TableRelation = "Vrste UGOD".Broj;
        }
        field(10; "Izvršitelj Broj"; Code[20])
        {
            Caption = 'Izvršitelj Broj';
        }
        field(11; "Izvršitelj puno Ime"; Text[50])
        {
            Caption = 'Izvršitelj puno Ime';
        }
        field(12; "Radno mjesto"; Text[50])
        {
            Caption = 'Radno mjesto';
        }
        field(13; "Opis Posla"; Text[250])
        {
            Caption = 'Opis Posla';
        }
        field(14; "Datum ugovora"; Date)
        {
            Caption = 'Datum ugovora';
        }
        field(15; "Datum roka izvršenja"; Date)
        {
            Caption = 'Datum roka izvršenja';
        }
        field(16; "Vrijeme izvršenja"; Text[100])
        {
            Caption = 'Vrijeme izvršenja';
        }
        field(17; "Dodatni komentar"; Text[250])
        {
            Caption = 'Dodatni komentar';
        }
        field(18; "Račun isplate"; Text[50])
        {
            Caption = 'Račun isplate';
        }
        field(19; "Bruto/Neto"; Option)
        {
            Caption = 'Bruto/Neto';
            OptionMembers = Bruto,Neto;
        }
        field(20; "Iznos ugovora (LVT)"; Decimal)
        {
            Caption = 'Iznos ugovora (LVT)';
        }
        field(21; "Iznos isplate (LVT)"; Decimal)
        {
            Caption = 'Iznos isplate (LVT)';
        }
        field(22; "Iznos Obrade (LVT)"; Decimal)
        {
            Caption = 'Iznos Obrade (LVT)';
        }
        field(25; "Banka računa isplate"; Text[50])
        {
            Caption = 'Banka računa isplate';
        }
        field(26; "Postotak priznatog izdatka"; Decimal)
        {
            Caption = 'Postotak priznatog izdatka';
        }
        field(27; "Postotak doprinosa MO I stup"; Decimal)
        {
            Caption = 'Postotak doprinosa MO I stup';
        }
        field(28; "Postotak doprinosa MO II stup"; Decimal)
        {
            Caption = 'Postotak doprinosa MO II stup';
        }
        field(29; "Postotak doprinosa ZO"; Decimal)
        {
            Caption = 'Postotak doprinosa ZO';
        }
        field(30; "Postotak poreza"; Decimal)
        {
            Caption = 'Postotak poreza';
        }
        field(32; "Iznos priznatog izdatka"; Decimal)
        {
            Caption = 'Iznos priznatog izdatka';
        }
        field(33; "Iznos doprinosa MO I stup"; Decimal)
        {
            Caption = 'Iznos doprinosa MO I stup';
        }
        field(34; "Iznos doprinosa MO II stup"; Decimal)
        {
            Caption = 'Iznos doprinosa MO II stup';
        }
        field(35; "Iznos doprinosa ZO"; Decimal)
        {
            Caption = 'Iznos doprinosa ZO';
        }
        field(36; "Iznos poreza"; Decimal)
        {
            Caption = 'Iznos poreza';
        }
        field(37; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(38; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(39; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(40; City; Text[30])
        {
            Caption = 'City';
        }
        field(41; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(42; County; Text[30])
        {
            Caption = 'County';
        }
        field(43; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(44; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(45; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(47; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(48; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(49; OIB; Code[13])
        {
            Caption = 'Employee ID';
        }
        field(50; "Sudionik II stupa MO"; Boolean)
        {
            Caption = 'Sudionik II stupa MO';
        }
        field(51; Primitak; Decimal)
        {
            Caption = 'Primitak';
        }
        field(52; "Osnovica za doprinose"; Decimal)
        {
            Caption = 'Osnovica za doprinose';
        }
        field(53; "Postotak Prireza"; Decimal)
        {
            Caption = 'Postotak Prireza';
        }
        field(54; "Iznos prireza"; Decimal)
        {
            Caption = 'Iznos prireza';
        }
        field(55; "Ukupno porez i prirez"; Decimal)
        {
            Caption = 'Ukupno porez i prirez';
        }
        field(56; "Porezna osnovica"; Decimal)
        {
            Caption = 'Porezna osnovica';
        }
        field(57; "Neto svota"; Decimal)
        {
            Caption = 'Neto svota';
        }
        field(58; "Šifra općine"; Text[4])
        {
            Caption = 'Šifra općine';
            TableRelation = "Općina";
        }
        field(59; "Brojčane ozn. za vrste dohotka"; Text[30])
        {
            Caption = 'Brojčane ozn. za vrste dohotka';
        }
        field(60; Stranac; Boolean)
        {
            Caption = 'Stranac';
        }
        field(61; Ime; Text[50])
        {
            Caption = 'Ime';
        }
        field(62; Prezime; Text[50])
        {
            Caption = 'Prezime';
        }
        field(63; "Postotak izdatka od dohotka"; Decimal)
        {
            Caption = 'Postotak izdatka od dohotka';
        }
        field(64; "Iznos izdatka od dohotka"; Decimal)
        {
            Caption = 'Iznos izdatka od dohotka';
        }
        field(65; "Postotak PDV-a"; Decimal)
        {
            Caption = 'Postotak PDV-a';
        }
        field(66; "Iznos PDV-a"; Decimal)
        {
            Caption = 'Iznos PDV-a';
        }
        field(67; "Šifra općine rada"; Text[4])
        {
            Caption = 'Šifra općine rada';
            TableRelation = "Općina";
        }
        field(70; "Osnova obračuna OO"; Code[20])
        {
            Caption = 'Osnov osiguranja';
            TableRelation = "Općina";
        }
        field(71; "Osnova obračuna I"; Code[20])
        {
            Caption = 'Invalidnost';
            TableRelation = Invaliditet;
        }
        field(72; "Osnova obračuna B"; Code[20])
        {
            Caption = 'Uvećani staž';
            TableRelation = "Uvećani staž"."Šifra";
        }
        field(73; "Osnova obračuna Z"; Code[20])
        {
            Caption = 'Zdravstveno osiguranje';
            TableRelation = "Uvećani staž";
        }
        field(74; "Osnova obračuna SSRR"; Text[4])
        {
            Caption = 'Osnova obračuna SSRR';
        }
        field(80; "Iznos ugovora"; Decimal)
        {
            Caption = 'Iznos ugovora';
        }
        field(81; "Iznos isplate"; Decimal)
        {
            Caption = 'Iznos isplate';
        }
        field(82; "Iznos obrade"; Decimal)
        {
            Caption = 'Iznos obrade';
        }
        field(83; "Valuta ugovora"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(84; Stipendija; Boolean)
        {
            Caption = 'Stipendija';
            Description = '060315 - mmatko';
        }
        field(85; "Neoporezivi iznos stipendije"; Decimal)
        {
            Caption = 'Neoporezivi iznos stipendije';
            Description = '060315 - mmatko';
        }
        field(86; "Krizni porez"; Decimal)
        {
            Description = 'DIGPL03';
        }
        field(87; "Netto sa KP"; Decimal)
        {
            Description = 'DIGPL03';
        }
        field(88; "Identifikator JOPPD"; Code[20])
        {
            Description = 'JOPPD';
            TableRelation = "JOPPD A str.";
        }
    }

    keys
    {
        key(Key1; "Broj Isplate", "Broj Ugovora")
        {
            Clustered = true;
        }
        key(Key2; "Izvršitelj Broj", "Datum isplate")
        {
        }
        key(Key3; "Identifikator R-S obrasca", OIB)
        {
        }
        key(Key4; "Izvršitelj Broj", "Šifra općine", "Brojčane ozn. za vrste dohotka", "Datum isplate")
        {
        }
        key(Key5; "Global Dimension 1 Code", "Broj Isplate", Prezime, Ime)
        {
        }
        key(Key6; Prezime, Ime, "Izvršitelj Broj", "Šifra općine", "Brojčane ozn. za vrste dohotka", "Datum isplate")
        {
        }
        key(Key7; "Izvršitelj Broj", "Šifra općine")
        {
        }
        key(Key8; "Izvršitelj Broj", "Šifra općine", "Brojčane ozn. za vrste dohotka")
        {
        }
        key(Key9; OIB, "Šifra općine")
        {
        }
        key(Key10; "Izvršitelj Broj", "Datum isplate", "Vrsta ugovora za obradu")
        {
        }
        key(Key11; "Izvršitelj Broj")
        {
        }
        key(Key12; "Broj Isplate", "Izvršitelj puno Ime")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR(msg001);
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        Employee: Record Employee;
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
        msg001: Label 'Ne možete obrisati knjiženu isplatu!';

    [Scope('OnPrem')]
    procedure AssistEdit(OldEmployee: Record Employee): Boolean
    begin
    end;

    [Scope('OnPrem')]
    procedure FullName(): Text[100]
    begin
    end;

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
}

