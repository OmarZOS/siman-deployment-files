
default:
	docker-compose up -d
	cd 3rd_party_software/elasticsearch && docker-compose up -d
	# cd 3rd_party_software/scylla_db && docker-compose up -d
	cd 3rd_party_software/my-sql && docker-compose up -d

down:
	docker-compose down
	cd 3rd_party_software/elasticsearch & docker-compose down
	cd 3rd_party_software/scylla_db & docker-compose down

install:
	git clone https://github.com/OmarZOS/doc-storage-server
	# waiting for next repositories