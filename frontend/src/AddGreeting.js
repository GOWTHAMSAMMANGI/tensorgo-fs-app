import React, { useState } from 'react';

const AddGreeting = ({ onAddGreeting }) => {
    const [newGreeting, setNewGreeting] = useState('');

    const handleSubmit = async (event) => {
        event.preventDefault();
        const response = await fetch('/api/greetings', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ content: newGreeting })
        });
        const data = await response.json();
        onAddGreeting(data);
        setNewGreeting('');
    };

    return (
        <form onSubmit={handleSubmit}>
            <input
                type="text"
                value={newGreeting}
                onChange={(event) => setNewGreeting(event.target.value)}
            />
            <button type="submit">Add Greeting</button>
        </form>
    );
};

export default AddGreeting;