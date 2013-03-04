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
MAIN = chap9.ClassRunner
SOURCEDIR = src
DISTDIR = bin
LIBDIR = lib
#
# file (use in jarfile)
#
SOURCE = $(foreach dir, $(SOURCEDIR), $(wildcard $(dir)/stone/*.java $(dir)/stone/ast/*.java $(dir)/chap6/*.java) $(dir)/chap7/*.java $(dir)/chap8/*.java $(dir)/chap9/*.java)
LIBS_ = $(foreach dir, $(LIBDIR), $(wildcard $(dir)/*.jar))
LIBS = $(subst  " ", :, $(LIBS_))
CLASSPATH = $(LIBS):$(DISTDIR)
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
	$(JAVAC) -cp $(LIBS) -d $(DISTDIR) $(SOURCE)


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
	@echo $(LIBS)
	$(JAVA) -cp $(CLASSPATH) $(MAIN)

.SUFFIXES: .java .class
