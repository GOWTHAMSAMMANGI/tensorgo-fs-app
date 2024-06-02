import React, { useState, useEffect } from 'react';
import GreetingList from './GreetingList';
import AddGreeting from './AddGreeting';

function App() {
    const [greetings, setGreetings] = useState([]);

    useEffect(() => {
        fetch('/api/greetings')
            .then(res => res.json())
            .then(data => setGreetings(data));
    }, []);

    const handleAddGreeting = (newGreeting) => {
        setGreetings([...greetings, newGreeting]);
    };

    return (
        <div className="App">
            <h1>Greetings App</h1>
            <GreetingList greetings={greetings} />
            <AddGreeting onAddGreeting={handleAddGreeting} />
        </div>
    );
}

export default App;