import React, { useEffect, useState } from 'react';
import { Outlet, useNavigate } from 'react-router-dom';
import '../Styles/Dashboard.css';
import Sidebar from '../components/Sidebar';
import { auth, db } from '../firebase/firebaseConfig';
import { doc, getDoc } from 'firebase/firestore';

interface RestaurantData {
  name: string;
  imageUrl: string;
}

const Dashboard: React.FC = () => {
  const navigate = useNavigate();
  const [userInitials, setUserInitials] = useState<string>('');
  const [restaurantData, setRestaurantData] = useState<RestaurantData | null>(null);

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged(async (user) => {
      if (user) {
        // Set user initials
        const initials = user.displayName
          ? user.displayName.split(' ').map((n) => n[0]).join('')
          : user.email?.substring(0, 2).toUpperCase();
        setUserInitials(initials || '');

        // Fetch restaurant data
        const userDocRef = doc(db, 'users', user.uid);
        const userDoc = await getDoc(userDocRef);
        if (userDoc.exists() && userDoc.data().restaurantId) {
          const restaurantDocRef = doc(db, 'restaurants', userDoc.data().restaurantId);
          const restaurantDoc = await getDoc(restaurantDocRef);
          if (restaurantDoc.exists()) {
            setRestaurantData({
              name: restaurantDoc.data().name,
              imageUrl: restaurantDoc.data().imageUrl,
            });
          }
        }
      } else {
        navigate('/login');
      }
    });

    return () => unsubscribe();
  }, [navigate]);

  const handleLogout = () => {
    auth.signOut();
    navigate('/login');
  };

  return (
    <div className="dashboard-container">
      <Sidebar />
      <main className="main-page">
        <div className="navbar">
          <div className="navbar-brand">Restaurant Dashboard</div>
          <div className="user-info">
            <span className="user-initials">{userInitials}</span>
            <button onClick={handleLogout}>Logout</button>
          </div>
        </div>
        <div className="content">
          {restaurantData ? (
            <div className="restaurant-info">
              <h2>{restaurantData.name}</h2>
              <img src={restaurantData.imageUrl} alt={restaurantData.name} />
            </div>
          ) : (
            <p>No restaurant data available. Create a restaurant to see it here.</p>
          )}
          <Outlet />
        </div>
      </main>
    </div>
  );
};

export default Dashboard;