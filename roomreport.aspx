<%@ Page Language="C#" AutoEventWireup="true" CodeFile="roomreport.aspx.cs" Inherits="roomreportr" %>

<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Application</title>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <link href="DataTables-1.9.4/media/css/jquery.dataTables.css" rel="stylesheet" />

    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>

    <script src="http://plugins.jquery.com/files/jquery.cookie.js" type="text/javascript"></script>
    <script src="carhartl-jquery-cookie-bf24a03/jquery.cookie.js" type="text/javascript"></script>
    <script src="DataTables-1.9.4/media/js/jquery.dataTables.js" type="text/javascript"></script>
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false">    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var tabs = $("#tabs").tabs({ cookie: { expires: 30 } });
            <%-- { cookie: { expires: 30} }
                tabs.find(".ui-tabs-nav").sortable({
                    axis: "x",
                    stop: function () {
                        tabs.tabs("refresh");
                    }
                });
                --%>

            $("#arrival_date_picker").datepicker({

                minDate: 0,
                onSelect: function (dateStr) {
                    $("#departure_date_picker").show();
                    var min = $(this).datepicker('getDate', '+1d'); // Selected date or today if none
                    min.setDate(min.getDate() + 1);
                    var max = new Date(min.getTime());
                    max.setMonth(max.getMonth() + 1); // Add one month
                    $('#departure_date_picker').datepicker('option', { minDate: min, maxDate: max });
                }
            });
            $("#departure_date_picker").datepicker({

                // minDate: $("#departure_date_picker").val()+1,
                //MaxDate: max.setMonth($("#arrival_date_picker")  + 1)

            });


            $("#roomlookup,#bt_Go,#direction").button()
                    .click(function (event) {
                    });

            $('#hotelroom').dataTable({
                "aoColumns": [
                    { "sTitle": "Room Type", "bSortable": false },
                    { "sTitle": "Occupancy", "sClass": "center", "bSortable": true },
                    { "sTitle": "Deposit", "sClass": "center", "bSortable": false },

                ],
                "aaSorting": []
            });
        });
    </script>
    <style type="text/css">
        .textbox {
            display: none;
        }

        .auto-style1 {
            height: 23px;
        }
        .auto-style2 {
            width: 72px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Room availability</a></li>

                </ul>
                <div id="tabs-1">

                    <div id="report" title="Hotel Room Lookup" runat="server">
                        <div id="form_hotel_room">
                            <div>
                                <div>
                                    <div style="float:left" >
                                        <table>
                                    <tr>
                                        <td class="auto-style1">
                                            <asp:Label ID="hotel_name_diplay" runat="server" Text="Hotel Name"></asp:Label>
                                        </td>
                                        <td class="auto-style1"></td>
                                        <td class="auto-style1">
                                            <asp:Label ID="hotel_name_view" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="rating_text" runat="server" Text="Rating"></asp:Label>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="rating_view" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                            <asp:TextBox ID="id_hotel" runat="server" Visible="false"></asp:TextBox>

                                        </td>
                                        <td></td>
                                        <td> <asp:TextBox ID="city" runat="server" Visible="false"></asp:TextBox></td>
                                    </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="state" runat="server" Visible="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                </table>
                                    </div>
                                    <div>
                                        <table>
                                            <tr>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Currnet Temp:</td>
                                                <td class="auto-style2">
                                                    <asp:Label ID="temp" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                
                                <div>
                                    <table>
                                        <tr>
                                            <td style="width: 30%">
                                                <div>
                                        <asp:Button ID="direction" runat="server" Text="Get Direction" OnClick="direction_Click" />
                                </div>
                                                <div runat="server" id="direction_for_map" visible="false">
                                                    Start Location: <asp:TextBox ID="tb_fromPoint" runat="server"></asp:TextBox>
                    End Location: <asp:TextBox ID="tb_endPoint" runat="server" Width="142px" ></asp:TextBox>
                    <input type="button" id="bt_Go" value="Let's go!" />

                                                </div>
                                                
              
                    
                    <div>
                        <cc1:GMap ID="direction_google" runat="server" Width="700px"/>
                    </div>
                   


                                            </td>
                                            <td>
                                                   <div id="div_directions" style="float:left;height: 300px; overflow-y: scroll; width: 450px;"></div>

                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="arrival_date" runat="server" Text="Arrival Date"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="arrival_date_picker" runat="server"></asp:TextBox>
                                        </td>

                                        <td>
                                            <asp:Label ID="daparture_date" runat="server" Text="Departure Date"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="departure_date_picker" runat="server" CssClass="textbox"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="roomlookup" runat="server" Text="Look for rooms" OnClick="roomlookup_Click" />
                                        </td>
                                    </tr>
                                </table>

                            </div>

                        </div>
                        <div id="view_hotel_room" runat="server">
                            <asp:GridView ID="hotelroom" runat="server" AutoGenerateColumns="False">

                                <Columns>
                                    <asp:BoundField HeaderText="(type)" DataField="Roome_Type"></asp:BoundField>
                                    <asp:BoundField HeaderText="Number of occupant" DataField="occupance"></asp:BoundField>

                                    <asp:BoundField HeaderText="(Yes/ No)" DataField="deposite"></asp:BoundField>

                                </Columns>
                            </asp:GridView>
                        </div>
                        <div runat="server" id="room_error"></div>
                    </div>


                </div>
            </div>

        


    </form>
</body>
</html>
