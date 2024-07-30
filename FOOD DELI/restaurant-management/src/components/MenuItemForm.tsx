// src/components/MenuItemForm.tsx

import React, { useState } from 'react';
import { db } from '../firebase/firebaseConfig';
import { collection, addDoc } from 'firebase/firestore';
import ImageUpload from './ImageUpload';

const MenuItemForm = ({ restaurantId }: { restaurantId: string }) => {
  const [name, setName] = useState('');
  const [price, setPrice] = useState(0);
  const [foodImageUrl, setImageUrl] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await addDoc(collection(db, `restaurants/${restaurantId}/menu`), {
        name,
        price,
        foodImageUrl,
      });
      setName('');
      setPrice(0);
      setImageUrl('');
    } catch (error) {
      console.error("Error adding menu item:", error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        placeholder="Food Name"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />
      <input
        type="number"
        placeholder="Price"
        value={price}
        onChange={(e) => setPrice(Number(e.target.value))}
      />
      <ImageUpload onUpload={(url) => setImageUrl(url)} />
      <button type="submit">Add Menu Item</button>
    </form>
  );
};

export default MenuItemForm;
