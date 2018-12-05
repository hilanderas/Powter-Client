version=0.1.0
project=powter-client
GITBOOK=$(CURDIR)/gitbook
DOCS=$(CURDIR)/docs
TESTFLOW=$(project)-testflow

.PHONY: build_book
build-book: $(GITBOOK)
	gitbook build $(GITBOOK) $(DOCS)


buildjobs = build-armv6 build-x86
build-%:
	cp -r ctl $(project)-$*
	sed -i "/ARCH =/c ARCH = $*" $(project)-$*/setting.env
	cd $(project)-$*/; find . -type f -exec md5sum {} \; > $(CURDIR)/$(project)-$*-$(version).md5; cd -
	mv $(project)-$*-$(version).md5 $(project)-$*
	zip -r $(project)-$*-$(version).zip $(project)-$*
	rm -rf $(project)-$*


build-testflow:
	cp -r testflow/script $(TESTFLOW)
	cp -r testflow/info*.yml $(TESTFLOW)
	cd $(TESTFLOW)/; find . -type f -exec md5sum {} \; > $(CURDIR)/$(TESTFLOW)-$(version).md5; cd -
	mv $(TESTFLOW)-$(version).md5 $(TESTFLOW)
	cd $(TESTFLOW) && make -f main.mk set_mod TESTMODE=prod
	sed -i '/^VERSION/c\VERSION=${version}' $(TESTFLOW)/main.mk
	zip -r $(TESTFLOW)-$(version).zip $(TESTFLOW)
	rm -rf $(TESTFLOW)


.PHONY: build 
build: $(buildjobs)

update-gitbook: $(GITBOOK)
	sed -i s/[0-9][.][0-9][.][0-9]/$(CUR)/g $(CURDIR)/gitbook/en/usage/testflow/PRODUCTIONMODE.md
	sed -i s/[0-9][.][0-9][.][0-9]/$(CUR)/g $(CURDIR)/gitbook/en/usage/DEPLOYMENT.md
	sed -i s/[0-9][.][0-9][.][0-9]/$(CUR)/g $(CURDIR)/gitbook/en/usage/usermanual/INSTALL.md
	sed -i s/[0-9][.][0-9][.][0-9]/$(CUR)/g $(CURDIR)/gitbook/en/SUMMARY.md

build-doc: update-gitbook build-book
