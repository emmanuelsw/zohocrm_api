# Zoho CRM API - Rails API

## Specs
* Ruby: 2.4.0
* Rails: 5.1.4
* DB: PostgreSQL
* Search engine: Ransack
* Websockets: ActionCable

## Set up
~~~ruby
git clone https://github.com/emmanuelsw/zohocrm_api.git
cd zohocrm_api
rails db:create
rails db:migrate
rails db:seed # create 10.000 fake records. (can take 2 minutes)
rails s -p 3001 # run server in port 3001
~~~

## Notes
* Important to run the server on port 3001 because the client uses port 3000 (default on rails applications).

## DB pick
* I chose PostgreSQL as database engine because it works perfectly in rails applications, it also has excellent performance when searching with large amounts of data. It integrates very well with search engines.

## Service specs

#### Add Zoho lead
* Description: Search Lead ID from Zoho API and add to database
* Endpoint: http://localhost:3001/api/v1/leads
* Method: POST
* Request param: 
  * **lead_id**: Lead ID number
* Success response: JSON object
~~~json
{
    "lead": {
        "id": 10001,
        "name": "Pepito Perez Perez",
        "company": "Redeker",
        "phone": "3206379980",
        "mobile": "3128063772",
        "lead_source": "Tienda en línea"
    }
}
~~~
* Error response: JSON
~~~json
{
    "errors": "Lead ID does not exist."
}
~~~

#### Search for people in database
* Description: Search for people that were previously added by name, company, phone or mobile
* Endpoint: http://localhost:3001/api/v1/leads/search
* Method: GET
* Request params:
  * **q**: search parameter
  * **page**: number of page (1 by default)
  * **size**: records per page
* Success response: JSON object
~~~json
{
    "leads": [
        {
            "id": 4872,
            "name": "Amelie D'Amore V",
            "company": "Torphy Group",
            "phone": "9727639413",
            "mobile": "5507891080",
            "lead_source": "Outdoors & Books"
        }
    ],
    "meta": {
        "current_page": 1,
        "total_count": 1
    }
}
~~~

#### Search for people in database by lead source
* Description: Search for people that were previously added by lead source
* Endpoint: http://localhost:3001/api/v1/leads/search_leadsource
* Method: GET
* Request params:
  * **q**: search parameter
  * **page**: number of page (1 by default)
  * **size**: records per page
* Success response: JSON object
~~~json
{
    "leads": [
        {
            "id": 10001,
            "name": "Pepito Perez Perez",
            "company": "Redeker",
            "phone": "3206379980",
            "mobile": "3128063772",
            "lead_source": "Tienda en línea"
        }
    ],
    "meta": {
        "current_page": 1,
        "total_count": 1
    }
}
~~~

