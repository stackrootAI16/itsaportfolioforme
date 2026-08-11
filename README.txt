PROJECT GUIDE
=============

1. Overview
-----------
This repository contains a portfolio website with a Node.js/Express backend and a static frontend.
- Backend: `backend/server.js`
- Frontend: `frontend/index.html`, `frontend/api.js`, `frontend/portfolio.js`, `frontend/config.js`

2. What is what
----------------
- `backend/package.json`: backend dependencies and startup scripts.
- `backend/server.js`: Express server, MongoDB via Mongoose, API routes, static file serving.
- `backend/.env.example`: example environment variables for development.
- `frontend/index.html`: portfolio page markup and page sections.
- `frontend/config.js`: runtime frontend configuration for API base URL.
- `frontend/api.js`: reusable API client for projects, skills, and contact.
- `frontend/portfolio.js`: dynamic page rendering and contact form handling.
- `Dockerfile`: container recipe for running the backend with static frontend files.
- `.gitignore`: ignores backend node_modules and local env files.

3. Environment setup
--------------------
Create a file `backend/.env` from `backend/.env.example`.
Use values such as:

PORT=3000
MONGODB_URI=mongodb://localhost:27017/portfolio
CLIENT_URL=http://localhost:8000

If deploying to production, set `MONGODB_URI` to your MongoDB Atlas URI and set `CLIENT_URL` to the deployed frontend origin.

4. Running locally
------------------
1. Install backend dependencies:
   cd backend
   npm install

2. Start MongoDB locally if using a local database:
   mkdir C:\data\db
   mongod --dbpath "C:\data\db"

3. Start backend server:
   cd backend
   npm start

4. Open frontend on a static server:
   cd frontend
   python -m http.server 8000
   open http://localhost:8000/

The frontend loads API data from the backend at `/api`.

5. Production hosting
---------------------
Recommended production architecture:
- Host the backend on Render, Railway, Heroku, or similar.
- Use MongoDB Atlas for the database.
- Host the frontend on Netlify, Vercel, or serve it from the same backend server.

6. Docker deployment
--------------------
Build and run the container:

docker build -t portfolio-app .
docker run -p 3000:3000 --env-file backend/.env portfolio-app

Then visit `http://localhost:3000`.

7. MongoDB Atlas
----------------
1. Create a free Atlas cluster.
2. Create a database user.
3. Add your application IP or allow access from anywhere for development.
4. Copy the connection string.
5. Set it in `backend/.env`:
   MONGODB_URI=mongodb+srv://<user>:<password>@cluster0.mongodb.net/portfolio?retryWrites=true&w=majority

8. Deployment notes
-------------------
- Ensure the host sets `PORT` and `MONGODB_URI` environment variables.
- Set `CLIENT_URL` to the frontend hostname if using CORS.
- If serving frontend from backend, no separate frontend host is required.

9. Maintaining the project
--------------------------
- Add new API endpoints in `backend/server.js`.
- Add new frontend pages by editing `frontend/index.html` and `frontend/portfolio.js`.
- Keep models in `backend/server.js` if the project remains small. For a larger project, move them to `backend/models/`.
- Keep secrets out of Git. Never commit `backend/.env`.

10. Troubleshooting
-------------------
- If `npm start` fails, check `backend/.env` and MongoDB connection.
- If frontend cannot reach the backend, verify `window.API_BASE_URL` in `frontend/config.js`.
- If the API returns 404 for `/api/*`, ensure the backend runs on the configured port.

11. Recommended improvements
---------------------------
- Add validation middleware for API requests.
- Move frontend to a proper build system (React or Vue) for better maintainability.
- Add authentication if contact/project management becomes private.
- Add logging and monitoring for production.
