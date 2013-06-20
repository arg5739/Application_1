using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceReference3;
using weather;
using System.Text;
using imdb;
using cal;
using maps;
using System.Web.Script.Serialization;
using Subgurim.Controles;

using System.Web.UI.HtmlControls;

public partial class _Default : System.Web.UI.Page
{
    protected string PostBackOption = "";
    protected void clearAll() 
    {
            weather_view.DataBind();
            weather_view_hour.DataBind();
            weather_ten_view.DataBind();
            location_text.Text = "";
            time_text.Text = "";
            errorWeather.Visible = false;
            errorWeather.InnerText = "";
            hotelisting_view.DataBind();
            view_hotels.Visible = false;
           
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        direction_for_map.Visible = false;
        weather_map.Add(new GMapUI());
        direction_google.Add(new GMapUI());
        GMapUIOptions options = new GMapUIOptions();
        options.maptypes_hybrid = false;
        options.keyboard = false;
        options.maptypes_physical = false;
        options.zoom_scrollwheel = false;
        
    }
    protected void get_hotel_list_Click(object sender, EventArgs e)
    {
        ServiceReference3.ServiceClient getlist = new ServiceReference3.ServiceClient();
        {
            clearAll();

            if (city_name.Text.Trim().Length != 0)
            {

                var result = getlist.getListOfHotel(city_name.Text, nameOfState.SelectedValue);

                var jss = new JavaScriptSerializer();
                var dict = jss.Deserialize<Dictionary<dynamic, dynamic>>(result);

                if (!dict["HotelListResponse"].ContainsKey("EanWsError"))
                {

                    city_name_hotel_display.Text = city_name.Text + " " + nameOfState.SelectedValue;
                    
                    view_hotels.Visible=true;

                    DataTable dt = new DataTable();
                    dt.Columns.Add(new DataColumn("hotel_name", typeof(string)));
                    dt.Columns.Add(new DataColumn("hotel_id", typeof(string)));
                    dt.Columns.Add(new DataColumn("Address", typeof(string)));
                    dt.Columns.Add(new DataColumn("Near_airport", typeof(string)));
                    dt.Columns.Add(new DataColumn("rating", typeof(string)));
                    dt.Columns.Add(new DataColumn("landmark", typeof(string)));
                    dt.Columns.Add(new DataColumn("descrip", typeof(string)));
                    dt.Columns.Add(new DataColumn("rates", typeof(string)));
                    dt.Columns.Add(new DataColumn("longi", typeof(string)));
                    dt.Columns.Add(new DataColumn("lati", typeof(string)));

                    int k = dict["HotelListResponse"]["HotelList"]["HotelSummary"].Length;
                    int i = 0;

                    while (k > i)
                    {

                        DataRow dr = dt.NewRow();

                        dr["hotel_name"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["name"];
                        dr["hotel_id"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["hotelId"];
                        dr["Address"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["address1"];
                        dr["Near_airport"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["airportCode"];
                        dr["rating"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["hotelRating"];
                        dr["landmark"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["locationDescription"];
                        
                        string descrip = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["shortDescription"];
                        descrip = descrip.Replace(@"&lt;p&gt;&lt;b&gt;", "");
                        descrip = descrip.Replace(@"Location. &lt;/b&gt; &lt;br /&gt;", "");
                        

                        dr["descrip"] = descrip;
                        dr["rates"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["highRate"] + " to " + dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["lowRate"];
                        dr["longi"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["longitude"];
                        dr["lati"] = dict["HotelListResponse"]["HotelList"]["HotelSummary"][i]["latitude"];


                        dt.Rows.Add(dr);
                        i++;

                    }


                    hotelisting_view.DataSource = dt;
                    hotelisting_view.DataBind();

                }
                else
                {
                    errorWeather.Visible = true;
                    errorWeather.InnerText = "Please Check City Name or State Name";
                }
            }
        }

    }

    protected void get_weather_Click(object sender, EventArgs e)
    {
        weather.ServiceClient movie = new weather.ServiceClient();


        if (Ten_day_check.Checked)
        {
            clearAll();

            if (city_name_weather.Text.Trim().Length != 0)
            {

                var result = movie.getWeather_tenDays(city_name_weather.Text, state_names_for_weather.SelectedValue, true);
                var jss = new JavaScriptSerializer();
                var dict = jss.Deserialize<Dictionary<string, dynamic>>(result);

                if (!dict["response"].ContainsKey("error") && !dict["response"].ContainsKey("results"))
                {
                    
                    location_text.Text = city_name_weather.Text + " " + state_names_for_weather.SelectedValue;
                    time_text.Text = dict["forecast"]["simpleforecast"]["forecastday"][0]["date"]["pretty"];



                    var map_result = movie.getWeather(city_name_weather.Text, state_names_for_weather.SelectedValue);
                    var map_jss = new JavaScriptSerializer();
                    var map_dict = map_jss.Deserialize<Dictionary<string, dynamic>>(map_result);

                    maps.ServiceClient map = new maps.ServiceClient();

                    // GLatLng latlng = new GLatLng( );
                    weather_map.setCenter(map.getDirection((map_dict["current_observation"]["display_location"]["latitude"]), (map_dict["current_observation"]["display_location"]["longitude"])), 10);
                    weather_map.Add(map.getMarker((map_dict["current_observation"]["display_location"]["latitude"]), (map_dict["current_observation"]["display_location"]["longitude"]), location_text.Text));
                   


                    DataTable dt = new DataTable();
                    dt.Columns.Add(new DataColumn("Time", typeof(string)));

                    dt.Columns.Add(new DataColumn("images", typeof(string)));

                    dt.Columns.Add(new DataColumn("high", typeof(string)));
                    dt.Columns.Add(new DataColumn("low", typeof(string)));

                    dt.Columns.Add(new DataColumn("prediction", typeof(string)));

                    int k = dict["forecast"]["simpleforecast"]["forecastday"].Count;
                    int i = 0;

                    while (k > i)
                    {

                        DataRow dr = dt.NewRow();

                        dr["time"] = dict["forecast"]["simpleforecast"]["forecastday"][i]["date"]["pretty"];
                        dr["images"] = ResolveUrl(dict["forecast"]["simpleforecast"]["forecastday"][i]["icon_url"]);
                        dr["high"] = dict["forecast"]["simpleforecast"]["forecastday"][i]["high"]["fahrenheit"] + " F (" + dict["forecast"]["simpleforecast"]["forecastday"][i]["high"]["celsius"] + " C)";
                        dr["low"] = dict["forecast"]["simpleforecast"]["forecastday"][i]["low"]["fahrenheit"] + " F (" + dict["forecast"]["simpleforecast"]["forecastday"][i]["low"]["celsius"] + " C)";
                        dr["prediction"] = dict["forecast"]["simpleforecast"]["forecastday"][i]["conditions"];


                        dt.Rows.Add(dr);
                        i++;

                    }


                    weather_ten_view.DataSource = dt;
                    weather_ten_view.DataBind();


                }
                else 
                {
                    errorWeather.Visible = true;
                    errorWeather.InnerText = "Please Check City Name or State Name";
                }
            }


        }
        else if (hourly_check.Checked)
        {

            clearAll();

            if (city_name_weather.Text.Trim().Length != 0)
            {

               
                var result = movie.getWeather_hourly(city_name_weather.Text, state_names_for_weather.SelectedValue, true);
                var jss = new JavaScriptSerializer();
                var dict = jss.Deserialize<Dictionary<string, dynamic>>(result);
                if (!dict["response"].ContainsKey("error") && !dict["response"].ContainsKey("results"))
                {
                    
                    location_text.Text = city_name_weather.Text + " " + state_names_for_weather.SelectedValue;
                    time_text.Text = dict["hourly_forecast"][0]["FCTTIME"]["pretty"];



                    var map_result = movie.getWeather(city_name_weather.Text, state_names_for_weather.SelectedValue);
                    var map_jss = new JavaScriptSerializer();
                    var map_dict = map_jss.Deserialize<Dictionary<string, dynamic>>(map_result);
                    
                     maps.ServiceClient map = new maps.ServiceClient();
                   
                    // GLatLng latlng = new GLatLng( );
                     weather_map.setCenter(map.getDirection((map_dict["current_observation"]["display_location"]["latitude"]), (map_dict["current_observation"]["display_location"]["longitude"])), 10);
                     weather_map.Add(map.getMarker((map_dict["current_observation"]["display_location"]["latitude"]), (map_dict["current_observation"]["display_location"]["longitude"]), location_text.Text));
                   



                    DataTable dt = new DataTable();
                    dt.Columns.Add(new DataColumn("Time", typeof(string)));

                    dt.Columns.Add(new DataColumn("images", typeof(string)));

                    dt.Columns.Add(new DataColumn("Temperature", typeof(string)));
                    dt.Columns.Add(new DataColumn("Feels like", typeof(string)));
                    dt.Columns.Add(new DataColumn("Relative Humidity", typeof(string)));
                    dt.Columns.Add(new DataColumn("prediction", typeof(string)));

                    int k = dict["hourly_forecast"].Count;
                    int i = 0;

                    while (k > i)
                    {

                        DataRow dr = dt.NewRow();

                        dr["time"] = dict["hourly_forecast"][i]["FCTTIME"]["pretty"];
                        dr["images"] = ResolveUrl(dict["hourly_forecast"][i]["icon_url"]);
                        dr["Temperature"] = dict["hourly_forecast"][i]["temp"]["english"] + " F (" + dict["hourly_forecast"][i]["temp"]["metric"] + " C)";
                        dr["Feels like"] = dict["hourly_forecast"][i]["feelslike"]["english"] + " F (" + dict["hourly_forecast"][i]["feelslike"]["metric"] + " C)";
                        dr["Relative Humidity"] = dict["hourly_forecast"][i]["humidity"] + " %";
                        dr["prediction"] = dict["hourly_forecast"][i]["wx"];


                        dt.Rows.Add(dr);
                        i++;

                    }


                    weather_view_hour.DataSource = dt;
                    weather_view_hour.DataBind();

                }
                else
                {
                    errorWeather.Visible = true;
                    errorWeather.InnerText = "Please Check City Name or State Name";
                }
            }
        }
        else
        {
            clearAll();
            
            if (city_name_weather.Text.Trim().Length != 0)
            {
                
                var result = movie.getWeather(city_name_weather.Text, state_names_for_weather.SelectedValue);
                var jss = new JavaScriptSerializer();
                var dict = jss.Deserialize<Dictionary<string, dynamic>>(result);
                if (!dict["response"].ContainsKey("error") && !dict["response"].ContainsKey("results"))
                {

                   
                    location_text.Text = dict["current_observation"]["display_location"]["full"];
                    time_text.Text = dict["current_observation"]["observation_time"];
                    maps.ServiceClient map = new maps.ServiceClient();
                   
                    // GLatLng latlng = new GLatLng( );
                    weather_map.setCenter(map.getDirection((dict["current_observation"]["display_location"]["latitude"]), (dict["current_observation"]["display_location"]["longitude"])), 10);
                    weather_map.Add(map.getMarker((dict["current_observation"]["display_location"]["latitude"]), (dict["current_observation"]["display_location"]["longitude"]), location_text.Text));
                    DataTable dt = new DataTable();

                    dt.Columns.Add("image", typeof(string));

                    dt.Columns.Add("temp", typeof(string));
                    dt.Columns.Add("feels", typeof(string));
                    dt.Columns.Add("humi", typeof(string));
                    dt.Columns.Add("wind", typeof(string));
                    dt.Columns.Add("wind_direction", typeof(string));


                    dt.Rows.Add(dict["current_observation"]["icon_url"], dict["current_observation"]["temperature_string"], dict["current_observation"]["feelslike_string"], dict["current_observation"]["relative_humidity"], dict["current_observation"]["wind_string"], dict["current_observation"]["wind_dir"]);
                    weather_view.DataSource = dt;
                    weather_view.DataBind();
                }
            }
            else
            {
                errorWeather.Visible = true;
                errorWeather.InnerText = "Please Check City Name or State Name";
            }
        }
    }


    protected void getMovie_Click(object sender, EventArgs e)
    {

        imdb.ServiceClient movie = new imdb.ServiceClient();
        var result = movie.getMovie(name.Text, "","");
        var jss = new JavaScriptSerializer();
        var dict = jss.Deserialize<Dictionary<string, string>>(result);
        if (dict["Response"].Equals("False"))
        {
            Label10.Text = dict["Error"];
            movie_info.Visible = true;
            Image img = new Image();
            img.ImageUrl = "";

            movie_image.Controls.Add(img);

            Label10.Text = "";

            genre_mov.Text = "";
            star_movie.Text = "";
            plot_mov.Text = "";
            year_movie.Text = "";
            movie_info.Visible = false;
        }
        else
        {
            movie_info.Visible = true;
            Image img = new Image();
            string image = dict["Poster"];

            movie_image.Controls.Add(new HtmlImage()
            {
                Src = image,

            });
            
            
            Label10.Text = dict["Title"];

            genre_mov.Text = dict["Genre"];
            star_movie.Text = dict["Actors"];
            plot_mov.Text = dict["Plot"];
            year_movie.Text = dict["Year"];

        }
       


    }


    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        cal.ServiceClient cal = new cal.ServiceClient();
        Label9.Text = DropDownList1.SelectedItem.Text;
        if (DropDownList1.SelectedItem.Text == "Division")
        {
            Double val1 = Convert.ToDouble(TextBox1.Text);
            Double val2 = Convert.ToDouble(TextBox2.Text);
            Double result = cal.divide(val1, val2);

            Label9.Text = Convert.ToString(result);
        }
        if (DropDownList1.SelectedItem.Text == "Addition")
        {
            Double val1 = Convert.ToDouble(TextBox1.Text);
            Double val2 = Convert.ToDouble(TextBox2.Text);
            Double result = cal.add(val1, val2);

            Label9.Text = Convert.ToString(result);
        }
        if (DropDownList1.SelectedItem.Text == "Subtraction")
        {
            Double val1 = Convert.ToDouble(TextBox1.Text);
            Double val2 = Convert.ToDouble(TextBox2.Text);
            Double result = cal.subtract(val1, val2);

            Label9.Text = Convert.ToString(result);
        }
        if (DropDownList1.SelectedItem.Text == "Multiplication")
        {
            Double val1 = Convert.ToDouble(TextBox1.Text);
            Double val2 = Convert.ToDouble(TextBox2.Text);
            Double result = cal.multiple(val1, val2);

            Label9.Text = Convert.ToString(result);
        }
    }
    protected void googleMap_Click(object sender, EventArgs e)
    {


            }
    protected void submit_wolfram_Click(object sender, EventArgs e)
    {
        if (inputWolframAlpha.Text.Trim().Length != 0) {
            wolfram.ServiceClient  wolf = new wolfram.ServiceClient();

            string output = (wolf.getWolframe(inputWolframAlpha.Text));


            //JsonValue value = JsonValue.Parse(output);

            var jss = new JavaScriptSerializer();
            var dict = jss.Deserialize<Dictionary<string, dynamic>>(output);
            if (dict["queryresult"]["@success"] == "true")
            {
                int count = (dict["queryresult"]["pod"].Count) - 1;

               // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>alert(" + count + ");</script>", false);
                wofram_output.Visible = true;
                if (count > 2)
                {
                    inside_wolf.Dispose();
                    HtmlGenericControl div = new HtmlGenericControl("div");
                    div.ID = "output_" + 0;
                    div.Attributes.Add("class", "pod");
                    var s = dict["queryresult"]["pod"][0]["subpod"]["img"]["@src"];

                    div.Controls.Add(new HtmlImage()
                    {
                        Src = s,
                        
                    });
                    inside_wolf.Controls.Add(div);
                    
                    HtmlGenericControl div1 = new HtmlGenericControl("div");
                    div1.ID = "output_" + 1;
                    div1.Attributes.Add("class", "pod");
                    var s1 = dict["queryresult"]["pod"][1]["subpod"]["img"]["@src"];
                    
                    div1.Controls.Add(new HtmlImage()
                    {
                        Src = s1,
                       
                    });
                    inside_wolf.Controls.Add(div1);


                    HtmlGenericControl div2 = new HtmlGenericControl("div");
                    div2.ID = "output_" + 1;
                    div2.Attributes.Add("class", "pod");
                    var s2 = dict["queryresult"]["pod"][2]["subpod"]["img"]["@src"];
                    div2.Controls.Add(new HtmlImage()
                    {
                        Src = s2,
                        
                    });
                   
                    inside_wolf.Controls.Add(div2);

                }


            }
            else {

                inside_wolf.Dispose();
                HtmlGenericControl div2 = new HtmlGenericControl("div");
                div2.ID = "output_" + 1;
                div2.Attributes.Add("class", "pod");

                div2.InnerHtml= "Cannot Found";
                
                inside_wolf.Controls.Add(div2);

            
            }
        }
    }
    
    
    protected void value_2Changes(object sender, EventArgs e)
    {
        unit_convert.ServiceClient unit = new unit_convert.ServiceClient();
        if (value_2_temp.SelectedValue.Equals("cel") && value_1_temp.SelectedValue.Equals("cel"))
        {
            value2.Text = value1.Text;

        }
        if (value_2_temp.SelectedValue.Equals("cel") && value_1_temp.SelectedValue.Equals("fahr"))
        {
            double value1_double = Convert.ToDouble(value1.Text);
            value2.Text = Convert.ToString(unit.fartoCels(value1_double));

        }
        if (value_2_temp.SelectedValue.Equals("cel") && value_1_temp.SelectedValue.Equals("kelvin"))
        {
            double value1_double = Convert.ToDouble(value1.Text);
            value2.Text = Convert.ToString(unit.kelvintoCel(value1_double));

        }

        if (value_2_temp.SelectedValue.Equals("fahr") && value_1_temp.SelectedValue.Equals("cel"))
        {
            double value1_double = Convert.ToDouble(value1.Text);
            value2.Text = Convert.ToString(unit.celsiusToFah(value1_double));

        }
        if (value_2_temp.SelectedValue.Equals("fahr") && value_1_temp.SelectedValue.Equals("kelvin"))
        {
            double value2_double = Convert.ToDouble(value1.Text);
            value2.Text = Convert.ToString(unit.KelvintoFah(value2_double));

        }
        if (value_2_temp.SelectedValue.Equals("fahr") && value_2_temp.SelectedValue.Equals("fahr"))
        {
            value2.Text = value1.Text;

        }
        if (value_2_temp.SelectedValue.Equals("kelvin") && value_1_temp.SelectedValue.Equals("kelvin"))
        {
            value2.Text = value1.Text;

        }
        if (value_2_temp.SelectedValue.Equals("kelvin") && value_1_temp.SelectedValue.Equals("fahr"))
        {
            double value2_double = Convert.ToDouble(value1.Text);
            value2.Text = Convert.ToString(unit.fartoKelvin(value2_double));
        }
        if (value_2_temp.SelectedValue.Equals("kelvin") && value_1_temp.SelectedValue.Equals("cel"))
        {
            double value2_double = Convert.ToDouble(value1.Text);
            value2.Text = Convert.ToString(unit.celciTokelvin(value2_double));
        }


    }
    protected void degree_conver(object sender, EventArgs e)
    {
        unit_convert.ServiceClient unit = new unit_convert.ServiceClient();
        if (value_2_degree.SelectedValue.Equals("degree") && value_1_degree.SelectedValue.Equals("degree"))
        {
           // double value2_double = Convert.ToDouble();
            degree_value2.Text = text_degree_1.Text;
        }
        if (value_2_degree.SelectedValue.Equals("rad") && value_1_degree.SelectedValue.Equals("degree"))
        {
            double value2_double = Convert.ToDouble(text_degree_1.Text);
            degree_value2.Text = Convert.ToString(unit.degreeToRadian(value2_double));
        }
        if (value_2_degree.SelectedValue.Equals("rad") && value_1_degree.SelectedValue.Equals("rad"))
        {
            degree_value2.Text = text_degree_1.Text;
        }
        if (value_2_degree.SelectedValue.Equals("degree") && value_1_degree.SelectedValue.Equals("rad"))
        {
            double value2_double = Convert.ToDouble(text_degree_1.Text);
            degree_value2.Text = Convert.ToString(unit.RadianToDegree(value2_double));
        }
    }
    protected void direction_Click(object sender, EventArgs e)
    {
        direction_for_map.Visible = true;
        maps.ServiceClient map = new maps.ServiceClient();

        direction_google.Add((map.getLetGO("bt_Go", tb_fromPoint.ClientID, tb_endPoint.ClientID, "div_directions")));
    }
    protected void trig_SelectedIndexChanged(object sender, EventArgs e)
    {
        trigono.ServiceClient trigono = new trigono.ServiceClient();
        if(trig.SelectedValue.Equals("sin"))
        {
            trig_ans.Text = Convert.ToString(trigono.sin(Convert.ToDouble(trig_text.Text)));
        }
         if(trig.SelectedValue.Equals("sinh"))
        {
            trig_ans.Text = Convert.ToString(trigono.Sinh(Convert.ToDouble(trig_text.Text)));
        }
        if(trig.SelectedValue.Equals("isin"))
        {
            trig_ans.Text = Convert.ToString(trigono.invSin(Convert.ToDouble(trig_text.Text)));
        }
        if(trig.SelectedValue.Equals("cos"))
        {
            trig_ans.Text = Convert.ToString(trigono.cos(Convert.ToDouble(trig_text.Text)));
        }
         if(trig.SelectedValue.Equals("cosh"))
        {
            trig_ans.Text = Convert.ToString(trigono.cosh(Convert.ToDouble(trig_text.Text)));
        }
        if(trig.SelectedValue.Equals("icos"))
        {
            trig_ans.Text = Convert.ToString(trigono.invCos(Convert.ToDouble(trig_text.Text)));
        }
       
        if(trig.SelectedValue.Equals("tan"))
        {
            trig_ans.Text = Convert.ToString(trigono.tan(Convert.ToDouble(trig_text.Text)));
        }
         if(trig.SelectedValue.Equals("tanh"))
        {
            trig_ans.Text = Convert.ToString(trigono.tanh(Convert.ToDouble(trig_text.Text)));
        }
        if(trig.SelectedValue.Equals("icos"))
        {
            trig_ans.Text = Convert.ToString(trigono.invTan(Convert.ToDouble(trig_text.Text)));
        }           
    }
    protected void sci_cal(object sender, EventArgs e)
    {
        cal.ServiceClient cal = new cal.ServiceClient();
        sci_cali.Text = sc_cal.SelectedItem.Text;
        if (sc_cal.SelectedItem.Text == "Division")
        {
            Double val1 = Convert.ToDouble(sc_val_1.Text);
            Double val2 = Convert.ToDouble(sc_val_2.Text);
            Double result = cal.divide(val1, val2);

            sci_cali.Text = Convert.ToString(result);
        }
        if (sc_cal.SelectedItem.Text == "Addition")
        {
            Double val1 = Convert.ToDouble(sc_val_1.Text);
            Double val2 = Convert.ToDouble(sc_val_2.Text);
            Double result = cal.add(val1, val2);

            sci_cali.Text = Convert.ToString(result);
        }
        if (sc_cal.SelectedItem.Text == "Subtraction")
        {
            Double val1 = Convert.ToDouble(sc_val_1.Text);
            Double val2 = Convert.ToDouble(sc_val_2.Text);
            Double result = cal.subtract(val1, val2);

            sci_cali.Text = Convert.ToString(result);
        }
        if (sc_cal.SelectedItem.Text == "Multiplication")
        {
            Double val1 = Convert.ToDouble(sc_val_1.Text);
            Double val2 = Convert.ToDouble(sc_val_2.Text);
            Double result = cal.multiple(val1, val2);

            sci_cali.Text = Convert.ToString(result);
        }

    }
    protected void sci_degree(object sender, EventArgs e)
    {
        unit_convert.ServiceClient unit = new unit_convert.ServiceClient();
        if (sc_val2.SelectedValue.Equals("degree") && sc_val1.SelectedValue.Equals("degree"))
        {
            // double value2_double = Convert.ToDouble();
            sc_text2.Text = sc_text1.Text;
        }
        if (sc_val2.SelectedValue.Equals("rad") && sc_val1.SelectedValue.Equals("degree"))
        {
            double value2_double = Convert.ToDouble(sc_text1.Text);
            sc_text2.Text = Convert.ToString(unit.degreeToRadian(value2_double));
        }
        if (sc_val2.SelectedValue.Equals("rad") && sc_val1.SelectedValue.Equals("rad"))
        {
            sc_text2.Text = sc_text1.Text;
        }
        if (sc_val2.SelectedValue.Equals("degree") && sc_val1.SelectedValue.Equals("rad"))
        {
            double value2_double = Convert.ToDouble(sc_text1.Text);
            sc_text2.Text = Convert.ToString(unit.RadianToDegree(value2_double));
        }
    }
}
