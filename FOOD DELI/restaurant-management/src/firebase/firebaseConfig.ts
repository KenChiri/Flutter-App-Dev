import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getAuth } from "firebase/auth";
import { getStorage } from "firebase/storage";
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = {
    apiKey: "AIzaSyBptVICgJcuzt-IcVIL_y-DxXrUujzmcQE",
    authDomain: "food-delivery-app-kabarak.firebaseapp.com",
    projectId: "food-delivery-app-kabarak",
    storageBucket: "food-delivery-app-kabarak.appspot.com",
    messagingSenderId: "464987784089",
    appId: "1:464987784089:web:61d6bf3abb4dd67d200908",
    measurementId: "G-BEBJ12E05E"
  };
  

const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const db = getFirestore(app);
const auth = getAuth(app);
const storage = getStorage(app);

export { db, auth, storage, analytics };
