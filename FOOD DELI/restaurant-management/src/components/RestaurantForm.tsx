import React, { useEffect, useState, FormEvent } from 'react';
import { auth, db } from '../firebase/firebaseConfig';
import { collection, doc, setDoc } from 'firebase/firestore';
import { useNavigate } from 'react-router-dom';
import ImageUpload from './ImageUpload';
import '../Styles/forms.css';

const RestaurantForm: React.FC = () => {
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [location, setLocation] = useState('');
  const [imageUrl, setImageUrl] = useState('');
  const [managerId, setManagerId] = useState('');
  const [alertMessage, setAlertMessage] = useState('');
  const [alertType, setAlertType] = useState<'success' | 'error' | ''>('');
  const navigate = useNavigate();

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged(user => {
      if (user) {
        setManagerId(user.uid);
      } else {
        setAlertMessage('You must be logged in to create a restaurant.');
        setAlertType('error');
        navigate('/');
      }
    });

    return () => unsubscribe();
  }, [navigate]);

  const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    console.log('Submitting form with values:', { name, description, location, imageUrl });
    
    if (!name || !description || !location || !imageUrl) {
      setAlertMessage('Please fill out all fields and upload an image.');
      setAlertType('error');
      return;
    }

    try {
      const newDocRef = doc(collection(db, 'restaurants'));
      await setDoc(newDocRef, {
        name,
        description,
        location,
        imageUrl,
        manager_id: managerId,
      });

      setAlertMessage('Restaurant added successfully!');
      setAlertType('success');
      
      // Clear form fields
      setName('');
      setDescription('');
      setLocation('');
      setImageUrl('');

      // Navigate after a short delay to allow the user to see the success message
      setTimeout(() => navigate('/dashboard'), 2000);
    } catch (error) {
      console.error('Error adding restaurant:', error);
      setAlertMessage('Error adding restaurant. Please try again.');
      setAlertType('error');
    }
  };

  const handleImageUpload = (url: string) => {
    console.log('Image uploaded, setting URL:', url);
    setImageUrl(url);
    setAlertMessage('Image uploaded successfully!');
    setAlertType('success');
  };

  return (
    <div className="restaurant-form-container">
      <h2>Create Restaurant</h2>
      {alertMessage && (
        <div className={`alert ${alertType}`}>
          {alertMessage}
        </div>
      )}
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label>Restaurant Name:</label>
          <input
            type="text"
            placeholder="Restaurant Name"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label>Description:</label>
          <textarea
            placeholder="Tell us about your delicious food!"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label>Location:</label>
          <input
            type="text"
            placeholder="Restaurant Location (e.g., Address, City)"
            value={location}
            onChange={(e) => setLocation(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <label>Restaurant Photo:</label>
          <ImageUpload onUpload={handleImageUpload} />
        </div>
        <button className="primary-button" type="submit" disabled={!imageUrl}>
          Submit Restaurant
        </button>
      </form>
    </div>
  );
};

export default RestaurantForm;