# hugo-site-apealive


pip install --process-dependency-links -r requirements.txt



mkdir static/css/nano
cp -a bower_components/nanogallery/dist/css/* static/css/nano
cp -a bower_components/nanogallery/dist/*.js static/js


optimise media:

>  sudo apt-get install jpegoptim
>  cd static/media/post/
>  jpegoptim -S50% ./

