using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Script.Serialization;

using ServiceReference3;
using weather;
using imdb;
using Subgurim.Controles;


public partial class roomreportr : System.Web.UI.Page
{
    static int count = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        direction_for_map.Visible = false;
       





        direction_google.Add(new GMapUI());
        GMapUIOptions options = new GMapUIOptions();
        options.maptypes_hybrid = false;
        options.keyboard = false;
        options.maptypes_physical = false;
        options.zoom_scrollwheel = false;
        
        count = Convert.ToInt32(Request.QueryString["count"]);
        if (count == 0)
        {
            string hotel_id = Request.QueryString["hotel_id"];
            string name = Request.QueryString["name"];
            string rating = Request.QueryString["rating"];
            string longi = Request.QueryString["long"];
            string lat = Request.QueryString["lat"];

          //  ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>alert(" + longi + ");</script>", false);
           // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>alert(" + lat + ");</script>", false);

            maps.ServiceClient map = new maps.ServiceClient();
           // GLatLng latlng = new GLatLng( );
            direction_google.setCenter(map.getDirection((lat), (longi)), 10);
            tb_endPoint.Text = lat + "," + longi;


            /*
            GMarker marker = new GMarker(map.getDirection((lat), (longi)));
            GInfoWindowOptions windowOptions = new GInfoWindowOptions();
            GInfoWindow commonInfoWindow = new GInfoWindow(marker, name, windowOptions);
            GMap1.Add(commonInfoWindow);
            */
            hotel_name_view.Text = name;
            rating_view.Text = rating;
            id_hotel.Text = hotel_id;
            city.Text = Request.QueryString["city_name"];
            state.Text = Request.QueryString["state_name"];
            count = 1;


            //Load temperature

            weather.ServiceClient movie = new weather.ServiceClient();

            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>alert(" + state.Text + ");</script>", false);


                var result = movie.getWeather(city.Text, state.Text );
                var jss = new JavaScriptSerializer();
                var dict = jss.Deserialize<Dictionary<string, dynamic>>(result);

                if (!dict["response"].ContainsKey("error") && !dict["response"].ContainsKey("results"))
                {
                   
                    temp.Text = dict["current_observation"]["temperature_string"];
                }  

        }
    }
    protected void roomlookup_Click(object sender, EventArgs e)
    {
        hotelroom.DataBind();
        ServiceReference3.ServiceClient getaval = new ServiceReference3.ServiceClient();

        if (arrival_date_picker.Text.Trim().Length != 0 && departure_date_picker.Text.Trim().Length != 0)
        {

            var result = getaval.getAvailOfHotel(id_hotel.Text, arrival_date_picker.Text, departure_date_picker.Text);
            var jss = new JavaScriptSerializer();
            var dict = jss.Deserialize<Dictionary<string, dynamic>>(result);
            if (Convert.ToInt32(dict["HotelRoomAvailabilityResponse"]["@size"]) != 0)
            {

                DataTable dt = new DataTable();

                dt.Columns.Add("Roome_Type", typeof(string));
                dt.Columns.Add("occupance", typeof(string));
                dt.Columns.Add("deposite", typeof(string));
                int number = 0;
                    
                while (number < Convert.ToInt32(dict["HotelRoomAvailabilityResponse"]["@size"]))
                {
                    DataRow dr = dt.NewRow();

                    dr["Roome_Type"] = dict["HotelRoomAvailabilityResponse"]["HotelRoomResponse"][number]["roomTypeDescription"];
                    dr["occupance"] = dict["HotelRoomAvailabilityResponse"]["HotelRoomResponse"][number]["rateOccupancyPerRoom"];
                    dr["deposite"] = dict["HotelRoomAvailabilityResponse"]["HotelRoomResponse"][number]["depositRequired"];
                    number++;
                    dt.Rows.Add(dr);
                }
                hotelroom.DataSource = dt;
                hotelroom.DataBind();
            }
            else
            {
                room_error.Visible = true;
                room_error.InnerText = dict["HotelRoomAvailabilityResponse"]["EanWsError"]["presentationMessage"];
            }
        }
        else
        {
            room_error.Visible = true;
            room_error.InnerText = "Please Check Dates";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>alert(" + tb_fromPoint.Text + ");</script>", false);

        GDirection direction = new GDirection();
        direction.autoGenerate = false;
        direction.fromElementId = tb_fromPoint.Text;
        direction.toElementId = tb_endPoint.Text;
        direction.divElementId = "div_directions";
        direction.clearMap = true;

        //direction.avoidHighways = true;
        //direction.travelMode = GDirection.GTravelModeEnum.G_TRAVEL_MODE_WALKING;
        //direction.locale = "en";

        direction_google.Add(direction);
    }
    protected void direction_Click(object sender, EventArgs e)
    {
        direction_for_map.Visible = true;
        maps.ServiceClient map = new maps.ServiceClient();

        direction_google.Add((map.getLetGO("bt_Go", tb_fromPoint.ClientID, tb_endPoint.ClientID, "div_directions")));
    }
}