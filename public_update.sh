# cd /mnt/c/Users/cimentadaj/Desktop/Documents/all_repos/cimentadaj.github.io
# cd /Users/cimentadaj/Downloads/gitrepo/cimentadaj.github.io

cd $PWD

echo Using R executable at /c/Program\ Files/R/R-3.5.1/bin/R.exe. Replace if the R version has changed.

# Change this when computer changes
/c/Program\ Files/R/R-3.5.1/bin/R.exe -e "blogdown::hugo_build()"


echo Git pull and commit in root
git pull

git add .

git commit -m 'New blog post'

git push

echo Checkout to master and pull
git checkout master

git pull

cd ..

echo Clone repo to temp_folder and remove old folder
git clone -b root https://github.com/cimentadaj/cimentadaj.github.io.git tempfolder

rm -R cimentadaj.github.io/*

cd tempfolder

echo Copy public folder
cp -R public/. ../cimentadaj.github.io/

cd ../cimentadaj.github.io

echo Remove temporary folder
rm -rf ../tempfolder

echo Add new changes in master
git add .

git commit -m 'New blog post'

git push

echo Checkout to root
git checkout root
