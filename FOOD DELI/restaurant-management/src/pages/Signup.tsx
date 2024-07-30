// src/components/Signup.tsx

import React, { useState } from 'react';
import { createUserWithEmailAndPassword } from 'firebase/auth';
import { auth, db } from '../firebase/firebaseConfig';
import { doc, setDoc } from 'firebase/firestore';
import { useNavigate } from 'react-router-dom';
import '../Styles/auth.css'; // Ensure you have styles for modern UI

const Signup: React.FC = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const userCredential = await createUserWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      await setDoc(doc(db, 'users', user.uid), {
        name,
        email,
        userId: user.uid,
        phoneNumber,
        role: 'manager',
      });
      navigate('/dashboard');
    } catch (error: any) {
      switch (error.code) {
        case 'auth/email-already-in-use':
          setError('Email is already in use by another account.');
          break;
        case 'auth/invalid-email':
          setError('Invalid email address format.');
          break;
        case 'auth/weak-password':
          setError('Password should be at least 6 characters.');
          break;
        default:
          setError('Error signing up. Please try again.');
      }
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-left">
        <h2>Sign Up</h2>
        <form onSubmit={handleSubmit} className="auth-form">
          <div className="form-group">
            <label>Name:</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
            />
          </div>
          <div className="form-group">
            <label>Email:</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <label>Password:</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <div className="form-group">
            <label>Phone Number:</label>
            <input
              type="text"
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
            />
          </div>
          <button type="submit" className="primary-button">Sign Up</button>
          {error && <p className="error-message">{error}</p>}
        </form>
      </div>
      <div className="auth-right">
        <h2>Welcome to Our Service!</h2>
        <p>Sign up to manage your restaurant and start serving delicious food today.</p>
        <img src="your-brand-image-url.jpg" alt="Brand" className="brand-image" />
      </div>
    </div>
  );
};

export default Signup;
