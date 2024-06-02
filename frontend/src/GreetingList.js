import React from 'react';

const GreetingList = ({ greetings }) => {
    return (
        <ul>
            {greetings.map(greeting => (
                <li key={greeting.id}>{greeting.content}</li>
            ))}
        </ul>
    );
};

export default GreetingList;