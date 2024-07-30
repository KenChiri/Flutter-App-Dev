// src/components/RestaurantCard.tsx

import React from 'react';

const RestaurantCard = ({ restaurant }: { restaurant: any }) => {
  return (
    <div className="restaurant-card">
      <img src={restaurant.imageUrl} alt={restaurant.name} />
      <h3>{restaurant.name}</h3>
    </div>
  );
};

export default RestaurantCard;
