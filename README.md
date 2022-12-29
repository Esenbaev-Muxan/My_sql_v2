
# My_SQLite
A simplified version of the real SQLite with a command-line interface (CLI).
Project developed by me and my colleague Tapabrata during our Full Stack Development Program at Qwasar Silicon Valley. 


## Description

1. Remake of SQLite Query Types: `SELECT`, `INSERT`, `UPDATE`, `DELETE`
2. Remake of SQLite Query Commands: `SET`, `VALUES`, `ORDER`, `JOIN`, `FROM`, `WHERE`

## Part I

---

Create a `class` called `MySqliteRequest` in `my_sqlite_request.rb.` It will have a similar behavior than a request on the real sqlite.

All methods, except run, will `return an instance of my_sqlite_request`. You will build the request by progressive call and `execute the request` by `calling run`.

`Each row must have an ID`

We will do only 1 join and 1 where per request.

`Example 1:`

```
request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request = request.where('birth_state', 'Indiana')
request.run
=> [{"name" => "Andre Brown"]
```

`Example 2:`

```
Input: MySqliteRequest('nba_player_data').select('name').where('birth_state', 'Indiana').run
Output: [{"name" => "Andre Brown"]
```

`Constructor`

```
def initialize
```

`SQL FROM Command`

```
From Implement a from method which must be present on each request. From will take a parameter and it will be the name of the table. (technically a table_name is also a filename (.csv))

def from(table_name)
```

`SQL SELECT Command`

```
From Implement a from method which must be present on each request. From will take a parameter and it will be the name of the table. (technically a table_name is also a filename (.csv))

def from(table_name)
```

## PART II
---
Create a program which will be a `Command Line Interface (CLI)` to your MySqlite class.
It will use `readline` and we will run it with ruby `my_sqlite_cli.rb`.

It will accept request with:

`SELECT|INSERT|UPDATE|DELETE` </br>
`FROM` </br>
`WHERE` (max 1) </br>
`JOIN ON` (max 1) </br>

## STEPS TO REPRODUCE
---

1. `cd mini_sqlite`
2. `ruby test.rb `

## PART I
---

- In test.rb, `uncomment` each Test case `one by one`
- Make sure to `comment` each test case as you progress

## PART II
---

- In test.rb, from Test 6, `copy/paste` the query into your `CLI`
- Make sure the `table name path` is `correct`
- To `exit the program`, enter `quit` or `ctrl + c`
