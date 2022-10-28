FROM node
COPY package.json package.json  
RUN yarn
# Add your source files
COPY . .  
ENV ENV production
CMD yarn build