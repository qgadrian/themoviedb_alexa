#! /bin/bash

echo "Package lambda build in a zip file"

make package

echo "Copy the package file to the output directory"

mkdir /output
cp lambda.zip /output/lambda.zip

echo "done!"

#exec $@

exit 0
