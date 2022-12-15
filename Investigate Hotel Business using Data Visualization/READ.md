# Investigate Hotel Business using Data Visualization
## Background
It is critical for a company to constantly assess its business performance. The company can take appropriate action to deal with a problem by analyzing business performance.

On this occasion, we will examine the hotel industry's performance. The primary goal of this project is to identify the customer actors involved in hotel bookings and their relationship to hotel cancellation rates. So three things will be analyzed in this project:
  
1. Monthly Hotel Booking Analysis Based on Hotel Type
2. Impact Analysis of Stay Duration on Hotel Bookings Cancellation Rates
3. Impact Analysis of Lead Time on Hotel Bookings Cancellation Rate

Based on the results of the insights obtained, visualization will be carried out so that they can be easily understood.

## Data
The data used in this project consists of 29 columns and 119390 rows. Data can be accessed [here](https://drive.google.com/file/d/1ZMvMRMFEhyMK-wUbpQZqYQ89JcARKtuC/view?usp=share_link). This project's creation makes the assumption that the data is either from an order placed in 119390 or that there are no duplicates.  The following is a description of each column in the data set.
| Column        | Description |
|:-------------|:-----|   
|hotel|  The datasets contains the booking information of two hotel. One of the hotels is a resort hotel and the other is a city hotel|
|is_canceled|  Value indicating if the booking was canceled (1) or not (0)
|lead_time|  Number of days that elapsed between the entering date of the booking into the PMS and the arrival date
|arrival_date_year|  Year of arrival date
|arrival_date_month|  Month of arrival date with 12 categories: “January” to “December”
|arrival_date_week_number|  Week number of the arrival date
|arrival_date_day_of_month|  Day of the month of the arrival date
|stays_in_weekend_nights|  Number of weekend nights (Saturday or Sunday) the guest stayed or booked to stay at the hotel
|stays_in_weekdays_nights|  Number of week nights (Monday to Friday) the guest stayed or booked to stay at the hotel BO and BL/Calculated by counting the number of week nights
|adults|  Number of adults
|children|  Number of children
|babies|  Number of babies
|meal|  Meal menu
|city|  City of origin
|market_segment|  Market segment designation. In categories, the term “TA” means “Travel Agents” and “TO” means “Tour Operators”
|distribution_channel|  Booking distribution channel. The term “TA” means “Travel Agents” and “TO” means “Tour Operators”
|is_repeated_guest|  Value indicating if the booking name was from a repeated guest (1) or not (0)
|previous_cancellations|  Number of previous bookings that were cancelled by the customer prior to the current booking
|previous_bookings_not_canceled|  Number of previous bookings not cancelled by the customer prior to the current booking
|booking_changes|  Number of changes/amendments made to the booking from the moment the booking was entered on the PMS until the moment of check-in or cancellation
|deposit_type|  No Deposit – no deposit was made; Non Refund – a deposit was made in the value of the total stay cost; Refundable – a deposit was made with a value under the total cost of stay
|agent|ID of the travel agency that made the booking
|company|ID of the company/entity that made the booking or responsible for paying the booking. ID is presented instead of designation for anonymity reasons
|days_in_waiting_list| Number of days the booking was in the waiting list before it was confirmed to the customer
|customer_type| Group – when the booking is associated to a group; Transient – when the booking is not part of a group or contract, and is not associated to other transient booking; Transient-party – when the booking is transient, but is associated to at least other transient booking
|adr| Average Daily Rate (Calculated by dividing the sum of all lodging transactions by the total number of staying nights)
|required_car_parking_spaces| Number of car parking spaces required by the customer
|total_of_special_requests| Number of special requests made by the customer (e.g. twin bed or high floor)
|reservation_status| Check-Out – customer has checked in but already departed; No-Show – customer did not check-in and did inform the hotel of the reason why  

## Stages
The project will go through several stages as follows:  
1. Load data:  load data from source
2. Data Preprocessing: handling missing values and incorrect values from numerical and categorical data
3. Insight and Visualization: Visualization and analysis of the visualization through the three things above
4. Business Recommendation: Provide business recommendations from the results of the analysis

## Results
### Monthly Hotel Booking Analysis Based on Hotel Type
![plot](./PortofolioData/Investigate Hotel Business using Data Visualization/images/case 1.png)
### Impact Analysis of Stay Duration on Hotel Bookings Cancellation Rates
### Impact Analysis of Lead Time on Hotel Bookings Cancellation Rate

## Business Recommendation
Based on the visualization and insight gained, the following businesses can be recommended to the hospitality industry:
1. Hospitality can implement a penalty system to the cancellation of hotel bookings carried out by the order to be able to reduce the cancellation rate of ordering.
2. Hospitality can apply the maximum term or order distance of no more than 3 months in order to reduce the cancellation rate.  
3. Hospitality can implement a reminder system, especially on the order that makes an order for a long time from the time of order.
4. The hotel can carry out marketing or offer products/or services in June-July and November-December where there are many customers.