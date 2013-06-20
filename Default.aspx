<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ register assembly="GMaps" namespace="Subgurim.Controles" tagprefix="cc1" %>


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
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDqYh4xbK_0vRftfuZAaYECBOazcGfnxi0&sensor=false">
    </script>
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false">    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $(document).tooltip();


            tab();

            $('#hotelisting').dataTable({
                "aoColumns": [
                    { "sTitle": "Hotel Name" },
                    { "sTitle": "Address" },
                    { "sTitle": "Near Airport" },
                    { "sTitle": "Rating", "sClass": "center" },
                    { "sTitle": "Landmark" }
                ]
            });

            $('#weather_view').dataTable({
                "aoColumns": [
                    { "sTitle": "Weather", "sClass": "center", "bSortable": false },
                    { "sTitle": "temperature", "sClass": "center", "bSortable": false },
                    { "sTitle": "Feels like", "sClass": "center", "bSortable": false },
                    { "sTitle": "Relative Humidity", "sClass": "center", "bSortable": false },
                    { "sTitle": "wind", "sClass": "center", "bSortable": false },
                    { "sTitle": "Wind Direction", "sClass": "center", "bSortable": false },

                ],
                "aaSorting": []
            });
            $('#weather_view_hour').dataTable({
                "aoColumns": [
                    { "sTitle": "Time", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Image", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Temperature", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Feels like", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Relative Humidity", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Prediction", "sClass": "center", "bSortable": false, },


                ],
                "aaSorting": [],

            });
            $('#weather_ten_view').dataTable({
                "aoColumns": [
                    { "sTitle": "Day", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Image", "sClass": "center", "bSortable": false, },
                    { "sTitle": "High", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Low", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Prediction", "sClass": "center", "bSortable": false, },


                ],
                "aaSorting": [],

            });

            var hotel_table = $('#hotelisting_view').dataTable({
                "aoColumns": [
                    { "sTitle": "Hotel Name", "sClass": "center", "bSortable": false, },
                    {
                        "sTitle": "hotel_id", "sClass": "center", "bSortable": false, "bSearchable": false,
                        "bVisible": false
                    },
                    { "sTitle": "Address", "sClass": "center", "bSortable": true, },
                    { "sTitle": "Near Airport", "sClass": "center", "bSortable": true, },
                    { "sTitle": "Rating", "sClass": "center", "bSortable": true, },
                    { "sTitle": "Landmark", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Description", "sClass": "center", "bSortable": false, },
                    { "sTitle": "Rates", "sClass": "center", "bSortable": false, },
                    {
                        "sTitle": "longi", "sClass": "center", "bSortable": false, "bSearchable": false,
                        "bVisible": false
                    },
                    {
                        "sTitle": "lati", "sClass": "center", "bSortable": false, "bSearchable": false,
                        "bVisible": false
                    },


                ],
                "aaSorting": [],

            });









            $('#hotelisting_view td').live('click', function () {
                var aPos = hotel_table.fnGetPosition(this);
                var aData = hotel_table.fnGetData(aPos[0]);
                var city = $("#city_name").val();
                var state = $("#nameOfState").val();

                window.open("roomreport.aspx?hotel_id=" + aData[1] + "&name=" + aData[0] + "&rating=" + aData[4] + "&count=0&long=" + aData[8] + "&lat=" + aData[9] + "&city_name="+city+"&state_name="+state, "_blank");

            });





            function tab() {
                var tabs = $("#tabs").tabs({ cookie: { expires: 30 } });
                <%-- { cookie: { expires: 30} }
                tabs.find(".ui-tabs-nav").sortable({
                    axis: "x",
                    stop: function () {
                        tabs.tabs("refresh");
                    }
                });
                --%>
            }

            // this fuction is for the accordion present inside the hotel tab. Name of accordion are 


            // this function is for buttons 
            $(function () {
                $("#get_hotel_list,#get_weather,#roomlookup, #getMovie, #submit_wolfram,#bt_Go,#direction").button()
                    .click(function (event) {
                    });
            });







        });



    </script>
    <style type="text/css">

        .pod {
        background-color: #FFFFFF;
    background-image: none;
    border: 1px solid #CCCCCC;
    border-radius: 6px 6px 6px 6px;
    clear: both;
    margin: 0 auto 15px;
    padding: 6px 0 4px;
    position: relative;
    width: 645px;
    z-index: 2;
            top: 0px;
            left: 0px;
        }
        .auto-style1 {
            width: 11%;
        }

        .auto-style3 {
            width: 6%;
        }


        .auto-style5 {
            width: 7%;
        }

        .auto-style6 {
            width: 5%;
        }

        .auto-style7 {
            width: 93px;
        }

        .auto-style8 {
            width: 224px;
        }

        .auto-style10 {
            width: 32px;
        }

        .auto-style11 {
            width: 937px;
        }
        .auto-style12 {
            width: 104px;
        }
        .auto-style13 {
            width: 479px;
        }
        .auto-style15 {
            width: 98px;
        }
        .auto-style16 {
            width: 173px;
        }
        .auto-style17 {
            width: 101px;
        }
        .auto-style18 {
            width: 134px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="tabs" style="height: 100%">
            <ul>
                <li><a href="#hotel">Hotel</a></li>
                <li><a href="#movie">IMDB</a></li>
                <li><a href="#weather">Weather</a></li>
                <li><a href="#maps">Google Maps</a></li>
                <li><a href="#cal">Calculator </a></li>
                <li><a href="#wolfram">Wolfram Alpha </a></li>
                <li><a href="#unit">Unit Conversion</a></li>
                <li><a href="#sciCal">Scientific Calculator</a></li>
            </ul>
            <div id="hotel" style="height: 100%">

                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/hotel_webservice/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                            <td><a href="https://github.com/arg5739/Hotel" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/application/documetations/Hotel%20Web%20Service.pdf" target="_blank">Documentation</a></td>

                        </tr>
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                <div id="hotel_options">
                    <h3>Look for Hotel</h3>
                    <div>
                        <div>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 20%">
                                        <asp:Label ID="name_state" runat="server" Text="Select State"></asp:Label>
                                    </td>
                                    <td style="width: 15%">
                                        <asp:DropDownList ID="nameOfState" runat="server" ToolTip="Select State">
                                            <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                            <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                            <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                            <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                            <asp:ListItem Value="CA">California</asp:ListItem>
                                            <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                            <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                            <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                            <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                            <asp:ListItem Value="FL">Florida</asp:ListItem>
                                            <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                            <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                            <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                            <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                            <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                            <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                            <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                            <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                            <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                            <asp:ListItem Value="ME">Maine</asp:ListItem>
                                            <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                            <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                            <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                            <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                            <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                            <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                            <asp:ListItem Value="MT">Montana</asp:ListItem>
                                            <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                            <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                            <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                            <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                            <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                            <asp:ListItem Value="NY">New York</asp:ListItem>
                                            <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                            <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                            <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                            <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                            <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                            <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                            <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                            <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                            <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                            <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                            <asp:ListItem Value="TX">Texas</asp:ListItem>
                                            <asp:ListItem Value="UT">Utah</asp:ListItem>
                                            <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                            <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                            <asp:ListItem Value="WA">Washington</asp:ListItem>
                                            <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                            <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                            <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:Label ID="Label1" runat="server" Text="Type City name"></asp:Label>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:TextBox ID="city_name" runat="server"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:Button ID="get_hotel_list" runat="server" Text="Submit" OnClick="get_hotel_list_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        ------
                  
                        <div id="hotel_list">
                            <div runat="server" style="visibility: hidden" id="view_hotels">
                                <div id="info_hotel_div" style="width: 50%">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="name_of_city_hotel" runat="server" Text="Location"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="city_name_hotel_display" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>

                                    </table>

                                </div>

                                <div id="map_for_hotel" style="width: 50%">
                                </div>

                            </div>
                            <div>
                                <asp:GridView ID="hotelisting_view" runat="server" AutoGenerateColumns="false">

                                    <Columns>
                                        <asp:BoundField HeaderText="" DataField="hotel_name"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="hotel_id"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="Address"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="Near_airport"></asp:BoundField>
                                        <asp:BoundField HeaderText="(Rating out of 5)" DataField="rating"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="landmark"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="descrip"></asp:BoundField>
                                        <asp:BoundField HeaderText="(High to Low)" DataField="rates"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="longi"></asp:BoundField>
                                        <asp:BoundField HeaderText="" DataField="lati"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>



                            </div>

                        </div>
                    </div>


                </div>
            </div>
            <div id="movie">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/IMDB/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                            <td><a href="https://github.com/arg5739/IMDB" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/application/documetations/IMDB%20Web%20Service.pdfl" target="_blank">Documentation</a></td>

                        </tr>
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                <div>
                    <table>
                        <tr>
                            <td class="auto-style3">
                                <table>
                                    <tr>
                                        <td style="width: 5%">
                                            <asp:Label ID="Label2" runat="server" Text="Name"></asp:Label>
                                        </td>
                                        <td class="auto-style5">
                                            <asp:TextBox ID="name" runat="server" Width="206px"></asp:TextBox>
                                        </td>
                                    </tr>


                                </table>
                                <asp:Button ID="getMovie" runat="server" Text="Search Movie"
                                    OnClick="getMovie_Click" />

                            </td>
                            <td class="auto-style1">
                                <asp:Label ID="Label10" runat="server" Text="" Font-Bold="True"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;
                </div>
                <div runat="server" id="movie_info" visible="false">
                    <table style="width: 100%">
                        <tr>
                            <td class="auto-style6">
                                <table style="height: 76px; width: 509px">
                                    <tr>
                                        <td class="auto-style10">
                                            <asp:Label ID="Label5" runat="server" Text="Year:"></asp:Label>
                                        </td>
                                        <td style="width: 50%">
                                            <asp:Label ID="year_movie" runat="server" Width="304px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style10">
                                            <asp:Label ID="Label6" runat="server" Text="Genre:"></asp:Label>
                                        </td>
                                        <td class="auto-style11">
                                            <asp:Label ID="genre_mov" runat="server" Width="304px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style10">
                                            <asp:Label ID="Label7" runat="server" Text="Starcast:"></asp:Label>
                                        </td>
                                        <td class="auto-style11">
                                            <asp:Label ID="star_movie" runat="server" Width="404px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style10">Plot:</td>
                                        <td class="auto-style11">
                                            <asp:Label ID="plot_mov" runat="server" Width="404px"></asp:Label>
                                        </td>
                                    </tr>
                                </table>

                            </td>
                            <td class="auto-style6">
                                <div runat="server" id="image_div_for_movie">
                                    <asp:PlaceHolder ID="movie_image" runat="server"></asp:PlaceHolder>
                                </div>
                            </td>
                        </tr>
                    </table>


                </div>

            </div>
            <div id="weather" style="height: auto">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/weather/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                            <td><a href="https://github.com/arg5739/weather" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/application/documetations/weather%20Web%20Service.pdf" target="_blank">Documentation</a></td>

                        </tr>
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                <!-- This div is for input form with bunch of options -->
                <div>
                    <table>
                        <tr>
                            <td class="auto-style1">
                                <asp:Label ID="state_name_lable_weather" runat="server" Text="State Name:"></asp:Label>
                            </td>
                            <td style="width: 10%">
                                <asp:DropDownList ID="state_names_for_weather" runat="server" ToolTip="Please select state from list">
                                    <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                    <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                    <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                    <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                    <asp:ListItem Value="CA">California</asp:ListItem>
                                    <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                    <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                    <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                    <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                    <asp:ListItem Value="FL">Florida</asp:ListItem>
                                    <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                    <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                    <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                    <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                    <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                    <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                    <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                    <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                    <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                    <asp:ListItem Value="ME">Maine</asp:ListItem>
                                    <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                    <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                    <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                    <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                    <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                    <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                    <asp:ListItem Value="MT">Montana</asp:ListItem>
                                    <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                    <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                    <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                    <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                    <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                    <asp:ListItem Value="NY">New York</asp:ListItem>
                                    <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                    <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                    <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                    <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                    <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                    <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                    <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                    <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                    <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                    <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                    <asp:ListItem Value="TX">Texas</asp:ListItem>
                                    <asp:ListItem Value="UT">Utah</asp:ListItem>
                                    <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                    <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                    <asp:ListItem Value="WA">Washington</asp:ListItem>
                                    <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                    <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                    <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="auto-style3"></td>
                            <td style="width: 10%">
                                <asp:Label ID="city_name_text" runat="server" Text="City Name"></asp:Label>
                            </td>
                            <td style="width: 10%">
                                <asp:TextBox ID="city_name_weather" runat="server" ToolTip="Please enter city" Width="155px"></asp:TextBox>
                            </td>
                            <td class="auto-style3"></td>
                            <td class="auto-style5">
                                <asp:Label ID="hourly_text" runat="server" Text="Hourly"></asp:Label>
                            </td>
                            <td class="auto-style6">
                                <asp:CheckBox ID="hourly_check" runat="server" ToolTip="Check for Hourly Update" />
                            </td>
                            <td class="auto-style3">
                                <asp:Label ID="ten_day_text" runat="server" Text="10 Days"></asp:Label>
                            </td>
                            <td class="auto-style5">
                                <asp:CheckBox ID="Ten_day_check" runat="server" ToolTip="Check for 10 days update" />
                            </td>
                            <td style="width: 10%">
                                <asp:Button ID="get_weather" runat="server" Text="Get Weather" OnClick="get_weather_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- this div is for outputing weather details -->
                &nbsp;&nbsp;
                <div runat="server" id="weather_map_div">

                    <div id="info_weather_div">

                        <div style="width: 50%; float: left;">
                            <table>
                                <tr>
                                    <td class="auto-style7">Loaction:
                                    </td>
                                    <td class="auto-style8">
                                        <asp:Label ID="location_text" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Time
                                    </td>
                                    <td>
                                        <asp:Label ID="time_text" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div style="width: 500px; height: 300px; float: left;" >
                            <cc1:GMap ID="weather_map" runat="server"/>
                        </div>

                    </div>
                    <asp:GridView ID="weather_view" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:ImageField DataImageUrlField="image"></asp:ImageField>



                            <asp:BoundField HeaderText="(in F and C)" DataField="temp"></asp:BoundField>
                            <asp:BoundField HeaderText="(in F an C)" DataField="feels"></asp:BoundField>
                            <asp:BoundField HeaderText="(in %)" DataField="humi"></asp:BoundField>
                            <asp:BoundField HeaderText="" DataField="wind"></asp:BoundField>

                            <asp:BoundField HeaderText="" DataField="wind_direction"></asp:BoundField>

                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="weather_view_hour" runat="server" AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField HeaderText="(Intervals of 1 hour)" DataField="time"></asp:BoundField>

                            <asp:ImageField DataImageUrlField="images"></asp:ImageField>

                            <asp:BoundField HeaderText="(in F and C)" DataField="Temperature"></asp:BoundField>
                            <asp:BoundField HeaderText="(in F and C)" DataField="Feels like"></asp:BoundField>
                            <asp:BoundField HeaderText="(in %)" DataField="Relative Humidity"></asp:BoundField>
                            <asp:BoundField HeaderText="" DataField="prediction"></asp:BoundField>

                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="weather_ten_view" runat="server" AutoGenerateColumns="False">

                        <Columns>
                            <asp:BoundField HeaderText="(Intervals of 1 Day)" DataField="time"></asp:BoundField>

                            <asp:ImageField DataImageUrlField="images"></asp:ImageField>

                            <asp:BoundField HeaderText="(in F and C)" DataField="high"></asp:BoundField>
                            <asp:BoundField HeaderText="(in F and C)" DataField="low"></asp:BoundField>

                            <asp:BoundField HeaderText="" DataField="prediction"></asp:BoundField>

                        </Columns>
                    </asp:GridView>
                    <div runat="server" id="errorWeather" style="display: block"></div>
                </div>
            </div>


            <div id="maps" style="height:700px">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/google_maps/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                            <td><a href="https://github.com/arg5739/google_maps" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <!--
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/hotel_webservice/Service.svc?wsdl" target="_blank">Documentation</a></td>

                        </tr> -->
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                <div>
                    <asp:Button ID="direction" runat="server" Text="Get Direction" OnClick="direction_Click" />
                </div>
                <div runat="server" id="direction_for_map" visible="false">
              <div runat="server"   style="float:left" >
                    Start Location: <asp:TextBox ID="tb_fromPoint" runat="server"></asp:TextBox>
                    End Location: <asp:TextBox ID="tb_endPoint" runat="server" Width="142px" ></asp:TextBox>
                    <input type="button" id="bt_Go" value="Let's go!" />
              
                    
                    <div>
                        <cc1:GMap ID="direction_google" runat="server" Width="700px"/>
                    </div>
                    
                  </div>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <div id="div_directions" style="float:left;height: 300px; overflow-y: scroll; width: 450px;"></div>
                   </div> 
                    
            </div>

            <div id="cal">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/Calculator/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                            <td><a href="https://github.com/arg5739/calculator_service" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/application/documetations/cal%20Web%20Service.pdf" target="_blank">Documentation</a></td>

                        </tr>
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                   <asp:Label ID="value_1" runat="server" Text="Value 1"></asp:Label>
                &nbsp;
            &nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Label ID="Label8" runat="server" Text="Value 2"></asp:Label>
                &nbsp;&nbsp;
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>Addition</asp:ListItem>
                <asp:ListItem>Subtraction</asp:ListItem>
                <asp:ListItem>Multiplication</asp:ListItem>
                <asp:ListItem>Division</asp:ListItem>
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label9" runat="server" Text=""></asp:Label>
            </div>
      
            <div id="wolfram">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/wolfram/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                           <td><a href="https://github.com/arg5739/Wolframe" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/application/documetations/wolframeWebService.pdf" target="_blank">Documentation</a></td>

                        </tr>
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;

                <table>
                    <tr>
                        <td class="auto-style12">
                            <asp:Label ID="input_for_wolfram" runat="server" Text="Query"></asp:Label>
                        </td>
                        <td class="auto-style13">
                            <asp:TextBox ID="inputWolframAlpha" runat="server" Width="382px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="submit_wolfram" runat="server" Text="Submit" OnClick="submit_wolfram_Click" />
                        </td>
                    </tr>
                </table>
                   
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <div runat="server" id="wofram_output" visible="false">
                    <asp:PlaceHolder ID="inside_wolf" runat="server"></asp:PlaceHolder>
                </div>
                        
                </div>

            <div id="unit">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/UnitConvert/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <tr>
                            <td><a href="https://github.com/arg5739/unit_conver" target="_blank">Web Service Code Download </a></td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/application/documetations/unitconversionWebService.pdf" target="_blank">Documentation</a></td>

                        </tr>
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                <div class="pod" >

                    <div>
                        Temperature
                    </div>
                    <div>

                    </div>
                    <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="value_1_temp" runat="server" AutoPostBack="true">
                                <asp:ListItem Value="cel">Celsius</asp:ListItem>
                                <asp:ListItem Value="fahr">Fahrenheit</asp:ListItem>
                                <asp:ListItem Value="kelvin">Kelvin</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;&nbsp;

                        </td>
                        <td class="auto-style16">
                            <asp:TextBox ID="value1" runat="server" Width="122px" ></asp:TextBox>
                            
                        </td>
                        <td class="auto-style17">
                            <asp:Label ID="Label3" runat="server" Text="Convert to"></asp:Label>
                        </td>
                        <td class="auto-style15">
                            <asp:DropDownList ID="value_2_temp" runat="server" AutoPostBack="true" OnSelectedIndexChanged="value_2Changes">
                                <asp:ListItem Value=""></asp:ListItem>
                                <asp:ListItem Value="cel">Celsius</asp:ListItem>
                                <asp:ListItem Value="fahr">Fahrenheit</asp:ListItem>
                                <asp:ListItem Value="kelvin">Kelvin</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                                             
                    </tr>
                    
                </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
                    Conversion:
                    &nbsp;<asp:Label ID="value2" runat="server"  Width="117px" Height="16px"></asp:Label>
                

                </div>
                   
               <div class="pod" >

                    <div>
                        Angle
                    </div>
                    <div>

                    </div>
                    <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="value_1_degree" runat="server" AutoPostBack="true">
                                <asp:ListItem Value="degree">Degree</asp:ListItem>
                                <asp:ListItem Value="rad">Radian</asp:ListItem>
                                
                            </asp:DropDownList>
                            &nbsp;&nbsp;

                        </td>
                        <td class="auto-style16">
                            <asp:TextBox ID="text_degree_1" runat="server" Width="122px" ></asp:TextBox>
                            
                        </td>
                        <td class="auto-style17">
                            <asp:Label ID="degree_value1" runat="server" Text="Convert to"></asp:Label>
                        </td>
                        <td class="auto-style15">
                            <asp:DropDownList ID="value_2_degree" runat="server" AutoPostBack="true" OnSelectedIndexChanged="degree_conver">
                                <asp:ListItem Value=""></asp:ListItem>
                                <asp:ListItem Value="degree">Degree</asp:ListItem>
                                <asp:ListItem Value="rad">Radian</asp:ListItem>
                                
                            </asp:DropDownList>
                        </td>
                                             
                    </tr>
                    
                </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
                    Conversion:
                    &nbsp;<asp:Label ID="degree_value2" runat="server"  Width="117px" ></asp:Label>
                

                </div>
                        
                </div>


            <div id="sciCal">
                <div class="info">
                    <table>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/UnitConvert/Service.svc?wsdl" target="_blank">WSDL Link </a></td>
                        </tr>
                        <!--
                        <tr>
                            <td>Web Service Code Download </td>

                        </tr>
                        <tr>
                            <td><a href="http://vhost3.cs.rit.edu/UnitConvert/Service.svc?wsdl" target="_blank">Documentation</a></td>

                        </tr> -->
                    </table>
                </div>
                &nbsp; &nbsp;
                &nbsp;
                <div class="pod" style="width:59%">

                    <div>
                        Calclulator
                    </div>
                    <div>
                        
            
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label16" runat="server" Text=""></asp:Label>
                    </div>
                    <table>
                    <tr>
                        <td class="auto-style15">
                            <asp:Label ID="Label14" runat="server" Text="Value 1"></asp:Label>
                            &nbsp;&nbsp;

                        </td>
                        <td class="auto-style18">
                            <asp:TextBox ID="sc_val_1" runat="server"></asp:TextBox>
                            
                        </td>
                        <td class="auto-style17">
                             <asp:Label ID="Label15" runat="server" Text="Value 2"></asp:Label>
                        </td>
                        <td class="auto-style15">
                            <asp:TextBox ID="sc_val_2" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="sc_cal" AutoPostBack="true" runat="server" OnSelectedIndexChanged="sci_cal">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>Addition</asp:ListItem>
                <asp:ListItem>Subtraction</asp:ListItem>
                <asp:ListItem>Multiplication</asp:ListItem>
                <asp:ListItem>Division</asp:ListItem>
            </asp:DropDownList>
                        </td>
                                             
                    </tr>
                    
                </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
                    Answer:
                    &nbsp;<asp:Label ID="sci_cali" runat="server"  Width="117px" Height="16px"></asp:Label>
                

                </div>
                   
               <div class="pod" >

                    <div>
                        Angle
                    </div>
                    <div style="height: 26px; width: 643px">

                    </div>
                    <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="sc_val1" runat="server" AutoPostBack="true">
                                <asp:ListItem Value="degree">Degree</asp:ListItem>
                                <asp:ListItem Value="rad">Radian</asp:ListItem>
                                
                            </asp:DropDownList>
                            &nbsp;&nbsp;

                        </td>
                        <td class="auto-style16">
                            <asp:TextBox ID="sc_text1" runat="server" Width="122px" ></asp:TextBox>
                            
                        </td>
                        <td class="auto-style17">
                            <asp:Label ID="Label12" runat="server" Text="Convert to"></asp:Label>
                        </td>
                        <td class="auto-style15">
                            <asp:DropDownList ID="sc_val2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="sci_degree">
                                <asp:ListItem Value=""></asp:ListItem>
                                <asp:ListItem Value="degree">Degree</asp:ListItem>
                                <asp:ListItem Value="rad">Radian</asp:ListItem>
                                
                            </asp:DropDownList>
                        </td>
                                             
                    </tr>
                    
                </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        
                    Conversion:
                    &nbsp;<asp:Label ID="sc_text2" runat="server"  Width="117px" ></asp:Label>
                

                </div>

                <div class="pod" >

                    <div>
                        Trigonometry
                    </div>
                    <div>

                    </div>
                    <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="trig_text" runat="server" Width="122px" ></asp:TextBox>
                             
                            &nbsp;&nbsp;

                        </td>
                        <td class="auto-style16">
                           <asp:DropDownList ID="trig" runat="server" AutoPostBack="true" OnSelectedIndexChanged="trig_SelectedIndexChanged">
                                <asp:ListItem Value="sin">Sine</asp:ListItem>
                                <asp:ListItem Value="sinh">hyperbolic Sine</asp:ListItem>
                                <asp:ListItem Value="isin">Inverse Sine</asp:ListItem>

                                <asp:ListItem Value="cos">Cosine</asp:ListItem>
                                <asp:ListItem Value="cosh">hyperbolic Cosine</asp:ListItem>
                                <asp:ListItem Value="icos">Inverse Cosine</asp:ListItem>

                                <asp:ListItem Value="tan">Tangent</asp:ListItem>
                                <asp:ListItem Value="tanh">hyperbolic Tangent</asp:ListItem>
                                <asp:ListItem Value="itan">Inverse Tangent</asp:ListItem>
                            </asp:DropDownList>
                            
                        </td>
                        <td class="auto-style17">
                            <asp:Label ID="trig_ans" runat="server" Text=""></asp:Label>
                        </td>
                                             
                    </tr>
                    
                </table>
                    
                </div>
                        
                </div>

            </div>
    </form>

</body>
</html>
