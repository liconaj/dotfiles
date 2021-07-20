cat $1 | while read app
do
	bash hideapp.sh $app
done
