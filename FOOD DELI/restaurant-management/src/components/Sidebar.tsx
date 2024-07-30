import React from 'react';
import { NavLink } from 'react-router-dom';


const Sidebar = () => {
  return (
    <div className="sidebar">
      <div className="sidebar-header">Dashboard</div>
      <ul className="sidebar-nav">
        <li>
          <NavLink
            to="/dashboard/create-restaurant"
            className={({ isActive }) => (isActive ? 'active' : 'sidebar-item')}
          >
            Create Restaurant
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/dashboard/add-menu-item"
            className={({ isActive }) => (isActive ? 'active' : 'sidebar-item')}
          >
            Add Menu Item
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/dashboard/view-orders"
            className={({ isActive }) => (isActive ? 'active' : 'sidebar-item')}
          >
            View Orders
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/dashboard/upload-item"
            className={({ isActive }) => (isActive ? 'active' : 'sidebar-item')}
          >
            Upload Item
          </NavLink>
        </li>
      </ul>
    </div>
  );
};

export default Sidebar;
