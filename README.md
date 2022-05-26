# DStruct -  RESTful Data Structures as a Service

It's often struct me how fundemental data structures such as stacks and queues end up being implemented in an ad hoc fashion as part of relational data modeling, and I've wondered what it would look like to implement various data structures generically in a relational data store. Meanwhile, I am starting a new job soon which uses C# and Azure after spending the past 6 years mostly using F# and AWS. Not a huge leap, but during my gap time between jobs (4 weeks!), I've decided to take on a project to sharpen my C# skills and get my hands dirty with Azure, and this seemed like a good project to structure my efforts around.

The idea specifically is to implement persistent data structures in Azure SQL - at least stack and queue - and to provide RESTful interfaces to them using C# and ASP.NET Core targeting .NET 6. Bonus if I can get some Kubernetes contianer orchestration going. I'd also like to make the app multi-tenate, perhaps using the Row Level Security (RLS) of Azure SQL. If I'm feeling particularly ambitious, I may blog about my adventures. I've secure the domain name `dstruct.dev`, but I don't plan to take on any paying customers... yet ;)

# Getting Started

We assume Linux OS with .NET 6, Docker, and SQL Server 2016 for Linux installed locally

## Create the Database

The following environment variables must be defined: `DSTRUCT_DB_SERVER`, `DSTRUCT_DB_USER`, `DSTRUCT_DB_PASSWORD`

Run `./sql/create-db.sh` to drop and recreate the `DStruct` database plus tables and stored proceedures. The `sqlcmd` tool can be used for querying.

## Start the apps

Run `docker compose up` to start the `www` and `api` projects running on ports 8080 and 9090 respectively.
