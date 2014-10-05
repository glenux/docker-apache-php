# vim: set ts=2 sw=2 noet:

PROJECT=semanticscuttle

build:
	docker build -t glenux/$(PROJECT) .

run: clean
	docker run -d --name $(PROJECT)_lampbox glenux/lampbox || \
        docker start $(PROEJCT)_lampbox || \
        true
	docker run --rm \
        --name $(PROJECT)_app \
        --link $(PROJECT)_lampbox:db \
        -v $$(pwd):/poieticgen \
        -p 8000:8000 \
        -i -t glenux/$(PROJECT)

test: clean
	docker run --rm \
        --name $(PROJECT)_app \
        --link $(PROJECT)_lampbox:db \
        -v $$(pwd):/poieticgen \
        -p 8000:8000 \
        -i -t glenux/$(PROJECT) /bin/bash

clean:
	docker rm -f $(PROJECT)_app || true

distclean:
	docker rm -f $(PROJECT)_lampbox || true

