page 50101 "ZY Purchase Receipt Lines"
{

    ApplicationArea = All;
    Caption = 'ZY Purchase Receipt Lines';
    PageType = List;
    SourceTable = "Purch. Rcpt. Line";
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
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field';
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
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ToolTip = 'Specifies the value of the Unit Price (LCY) field';
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Qty. Rcd. Not Invoiced field';
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
                Caption = 'Show Purchase Order';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchaseOrderHdr: Record "Purchase Header";
                    NotFound: Label 'No Purchase Order was found.';
                begin
                    if PurchaseOrderHdr.Get(PurchaseOrderHdr."Document Type"::Order, Rec."Order No.") then
                        PAGE.Run(PAGE::"Purchase Order", PurchaseOrderHdr)
                    else
                        Message(NotFound);
                end;
            }
            action(ShowDocument2)
            {
                Caption = 'Show Posted Purchase Receipt';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchaseRcptHdr: Record "Purch. Rcpt. Header";
                begin
                    if PurchaseRcptHdr.Get(Rec."Document No.") then
                        PAGE.Run(PAGE::"Posted Purchase Receipt", PurchaseRcptHdr);
                end;
            }
            action(ShowAllLines)
            {
                Caption = 'Show All Receipt Lines';
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
            action(ShowRcdNotInvoicedLines)
            {
                Caption = 'Show Received not Invoiced Lines';
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetFilter("Qty. Rcd. Not Invoiced", '>%1', 0);
                    if Rec.FindFirst() then;
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        Rec.SetFilter("Qty. Rcd. Not Invoiced", '>%1', 0);
        if Rec.FindFirst() then;
    end;
}
