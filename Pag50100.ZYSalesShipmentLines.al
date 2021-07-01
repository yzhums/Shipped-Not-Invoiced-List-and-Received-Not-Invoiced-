page 50100 "ZY Sales Shipment Lines"
{

    ApplicationArea = All;
    Caption = 'ZY Sales Shipment Lines';
    PageType = List;
    SourceTable = "Sales Shipment Line";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field';
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field';
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Qty. Shipped Not Invoiced field';
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies the value of the Quantity Invoiced field';
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field';
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Order Line No. field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ShowDocument)
            {
                Caption = 'Show Sales Order';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesOrderHdr: Record "Sales Header";
                    NotFound: Label 'No Purchase Order was found.';
                begin
                    if SalesOrderHdr.Get(SalesOrderHdr."Document Type"::Order, Rec."Order No.") then
                        PAGE.Run(PAGE::"Sales Order", SalesOrderHdr)
                    else
                        Message(NotFound);
                end;
            }
            action(ShowDocument2)
            {
                Caption = 'Show Posted Sales Shipment';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesShipmentHdr: Record "Sales Shipment Header";
                    B12: Record "Purch. Rcpt. Line";
                begin
                    if SalesShipmentHdr.Get(Rec."Document No.") then
                        PAGE.Run(PAGE::"Posted Sales Shipment", SalesShipmentHdr);
                end;
            }
            action(ShowAllLines)
            {
                Caption = 'Show All Shipped Lines';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    if Rec.FindFirst() then;
                end;
            }
            action(ShowShippedNotInvoicedLines)
            {
                Caption = 'Show Shipped not Invoiced Lines';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetFilter("Qty. Shipped Not Invoiced", '>%1', 0);
                    if Rec.FindFirst() then;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Qty. Shipped Not Invoiced", '>%1', 0);
        if Rec.FindFirst() then;
    end;
}
