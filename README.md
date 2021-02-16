# A blog with Gatsby + Notion + Netlify
Just write in Notion and you will get a beautiful blog published automatically, So, Why not give up *hexo g, hexo d*, Do with me.

**what you need**

- Vercel account
- Notion account

## 😎**QuiK Start**

## In Notion

- duplicates the page in your notion /link

  https://www.notion.so/2110ef870a6d43b5a01e7b0f801ff8b6?v=add17c6a7c984a5187568b0130b820cd

- share there to the web

## In Gatsby

- change the gatsby-config.js

```jsx
module.exports = {
    plugins: [
        {
		      resolve: `@conradlin/gatsby-source-notion-database`,
		      options: {
	        sourceConfig: [
	          {
							# replace the name and table with your notion config
	            name: 'posts', 
	            table: 'https://www.notion.so/2110ef870a6d43b5a01e7b0f801ff8b6?v=add17c6a7c984a5187568b0130b820cd',
	            cacheType: 'html'
	          }
	        ]
	      }
	    },
    ],
}
```

*there is a network bug in the project,if we build with the repo in Vercel , you will get fetch error when get the notion page, so, we can't use the Vercel to deploy directly, but we can build it with github actions ,then push it to Vercel.( if you use netlify, there' no problem)*

## In Github

- follow the workflow config and add the secrets in your repo.

  ```yaml
  on: 
   push
   schedule:
      - cron:  '0 */12 * * *' # you can change 
        
  jobs: 
    build:
      runs-on: ubuntu-latest 
  
      steps: 
        - name: Checkout 
          uses: actions/checkout@v1
        - name: Setup node 
          uses: actions/setup-node@v1
          with:
            node-version: "12.x"
        - name: Set Gatsby
          run: yarn install  
           
        - name: run deploy.sh 
          env: 
            GITHUB_TOKEN: ${{ secrets.MY_GITHUB_TOKEN }} # add your Github token in your sercets
          run: bash deploy.sh  
  
  ```

- change the deploy.sh

  ```bash
  # !/usr/bin/env sh
  set -e
  yarn build 
  cd public 
  find . -type f -name '*.map' | xargs rm
  echo come
  
  echo Start_in_GitHub
  
  if [ -z "$GITHUB_TOKEN" ]; then
    msg='deploy'
    githubUrl=git@github.com:<your name>/<your page repo>.git #it's yout page repo not this
  else
    msg='来自github action的自动部署'
    githubUrl=https://Difers:${GITHUB_TOKEN}@github.com/Difers/Difer.git
    git config --global user.name "<your name>" # replace it with yours
    git config --global user.email "<your email>" # replace it with yours
  fi
  git init
  git add -A
  git commit -m "${msg}"
  git push -f $githubUrl master:master # push to github
  ```

## In vercel

- deploy your page repo in vercel ( ‼️not this repo)
- wait for seconds and you will get the cool blog

## Usage

- just write waht you want in the notion page
- make sure every column is filled and only the *published* will be published

## Customize

if you want use another theme, there are some reference for you

- the plugin connect Notion with Gatsby

[mayneyao/gatsby-source-notion-database](https://github.com/mayneyao/gatsby-source-notion-database)

- there are many cool Gatsby theme

[Starter Library](https://www.gatsbyjs.com/starters/?v=2)
