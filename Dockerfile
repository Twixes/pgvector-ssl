ARG PG_MAJOR=17
FROM postgres:$PG_MAJOR
ARG PG_MAJOR

COPY . /tmp/pgvector

RUN apt-get update && \
		apt-mark hold locales && \
		apt-get install -y --no-install-recommends openssl sudo build-essential postgresql-server-dev-$PG_MAJOR && \
		cd /tmp/pgvector && \
		make clean && \
		make OPTFLAGS="" && \
		make install && \
		mkdir /usr/share/doc/pgvector && \
		cp LICENSE README.md /usr/share/doc/pgvector && \
		rm -r /tmp/pgvector && \
		apt-get remove -y build-essential postgresql-server-dev-$PG_MAJOR && \
		apt-get autoremove -y && \
		apt-mark unhold locales && \
		rm -rf /var/lib/apt/lists/* && \
		echo "postgres ALL=(root) NOPASSWD: /usr/bin/mkdir, /bin/chown, /usr/bin/openssl" > /etc/sudoers.d/postgres

# Add init scripts while setting permissions
COPY --chmod=755 init-ssl.sh /docker-entrypoint-initdb.d/init-ssl.sh
COPY --chmod=755 wrapper.sh /usr/local/bin/wrapper.sh

ENTRYPOINT ["wrapper.sh"]
CMD ["postgres", "--port=5432"]
