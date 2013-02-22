#
# command
#
BIN = /Library/Java/JavaVirtualMachines/jdk1.7.0_07.jdk/Contents/Home/bin
JAVAC = $(BIN)/javac #-verbose
JAVA = $(BIN)/java
JAR = $(BIN)/jar

##########
# variable
#
MAIN = chap5.ParserRunner
SOURCEDIR = src
DISTDIR = bin
LIBDIR = lib
#
# file (use in jarfile)
#
SOURCE = $(foreach dir, $(SOURCEDIR), $(wildcard $(dir)/stone/*.java $(dir)/stone/ast/*.java $(dir)/chap5/*.java))
#CLASSPATH = $(DISTDIR):$(DISTDIR)/stone:$(DISTDIR)/stone/ast:$(DISTDIR)/chap3
CLASSPATH = $(DISTDIR)
CLASS = application/*class util/*class security/*class

##########
# make jarfile
#
$(JARFILE): compile $(MANIFEST)
	$(JAR) cvmf $(MANIFEST) $(JARFILE) $(CLASS)
#
# make manifest
#
$(MANIFEST):
	echo Main-Class: $(MAIN) > $(MANIFEST)
	echo Class-Path: $(CLASSPATH) >> $(MANIFEST)
#
# compile
#
compile: clean
	@echo $(SOURCEDIR)
	$(JAVAC) -d $(DISTDIR) $(SOURCE)


##########
# make jarfile, and operation test
#
test go: $(JARFILE)
	$(JAVA) -jar $(JARFILE)


##########
# delete classfile, jarfile, manifest
#
clean:
	rm -fr $(DISTDIR)
	mkdir $(DISTDIR)


all: clean compile
	$(JAVA) -cp $(CLASSPATH) $(MAIN)

.SUFFIXES: .java .class
