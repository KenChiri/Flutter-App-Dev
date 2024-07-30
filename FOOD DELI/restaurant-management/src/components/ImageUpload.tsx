// src/components/ImageUpload.tsx
import React, { useState } from 'react';
import { storage } from '../firebase/firebaseConfig';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';

const ImageUpload = ({ onUpload }: { onUpload: (url: string) => void }) => {
  const [progress, setProgress] = useState(0);
  const [isUploading, setIsUploading] = useState(false);
  const [uploadComplete, setUploadComplete] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setIsUploading(true);
      setUploadComplete(false);
      const storageRef = ref(storage, `images/${file.name}`);
      const uploadTask = uploadBytesResumable(storageRef, file);

      uploadTask.on(
        'state_changed',
        (snapshot) => {
          const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          setProgress(progress);
        },
        (error) => {
          console.error('Upload failed', error);
          setIsUploading(false);
        },
        async () => {
          const downloadURL = await getDownloadURL(uploadTask.snapshot.ref);
          onUpload(downloadURL);
          setIsUploading(false);
          setUploadComplete(true);
          console.log('Image uploaded successfully. URL:', downloadURL);
        }
      );
    }
  };

  return (
    <div>
      <input type="file" onChange={handleChange} />
      {isUploading && <progress value={progress} max="100">{progress.toFixed(2)}%</progress>}
      {uploadComplete && <p>Upload complete!</p>}
    </div>
  );
};

export default ImageUpload;