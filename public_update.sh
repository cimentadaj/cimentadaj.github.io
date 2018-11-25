# cd /mnt/c/Users/cimentadaj/Desktop/Documents/all_repos/cimentadaj.github.io
# cd /Users/cimentadaj/Downloads/gitrepo/cimentadaj.github.io

cd $PWD

git pull

git add .

git commit -m 'New blog post'

git push

git checkout master

git pull

cd ..

git clone -b root https://github.com/cimentadaj/cimentadaj.github.io.git tempfolder

rm -R cimentadaj.github.io/*

cd tempfolder

cp -R public/. ../cimentadaj.github.io/

cd ../cimentadaj.github.io

rm -rf ../tempfolder

git add .

git commit -m 'New blog post'

git push

git checkout root
