# pgvector-ssl

[pgvector](https://github.com/pgvector/pgvector) with Postgres SSL support in the Docker image.

The motivation for this fork is running Postgres with pgvector on [Railway](https://railway.app/), which requires SSL – but feel free to use for other purposes too. The only change versus upstream is the Dockerfile gaining SSL setup, directly copied from [railwayapp-templates/postgres-ssl](https://github.com/railwayapp-templates/postgres-ssl/blob/main/Dockerfile.latest).
