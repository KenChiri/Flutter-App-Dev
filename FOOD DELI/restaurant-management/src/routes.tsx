// src/routes.tsx

import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Login from '../src/pages/Login';
import Dashboard from '../src/pages/Dashboard';
import RestaurantForm from './components/RestaurantForm';
import MenuItemForm from './components/MenuItemForm';
import Signup from './pages/Signup';
import ProtectedRoute from './components/ProtectedRoute';

const AppRoutes: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          }
        >
          {/* Nested routes for Dashboard */}
          <Route path="create-restaurant" element={<RestaurantForm />} />
          <Route path="add-menu-item" element={<MenuItemForm restaurantId=''/>} />
        </Route>
      </Routes>
    </Router>
  );
};

export default AppRoutes;
