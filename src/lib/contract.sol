// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Web3TikTok {
    struct User {
        address userAddress;
        string username;
        bool exists;
    }

    struct Video {
        uint256 id;
        address author;
        string arweaveCID;
        uint256 likes;
        uint256 commentCount;
    }

    struct Comment {
        uint256 id;
        uint256 videoId;
        address author;
        string content;
    }

    mapping(address => User) public users;
    mapping(string => bool) public usernameExists;
    mapping(uint256 => Video) public videos;
    mapping(uint256 => Comment[]) public videoComments;
    mapping(address => mapping(uint256 => bool)) public userLikes;

    uint256 public videoCount;
    uint256 public commentCount;

    event UserRegistered(address indexed userAddress, string username);
    event VideoUploaded(uint256 indexed videoId, address indexed author, string arweaveCID);
    event VideoLiked(uint256 indexed videoId, address indexed liker);
    event CommentAdded(uint256 indexed videoId, uint256 indexed commentId, address indexed author);

    function registerUser(string memory _username) public {
        require(!users[msg.sender].exists, "User already registered");
        require(!usernameExists[_username], "Username already taken");
        require(bytes(_username).length > 0, "Username cannot be empty");

        users[msg.sender] = User(msg.sender, _username, true);
        usernameExists[_username] = true;

        emit UserRegistered(msg.sender, _username);
    }

    function uploadVideo(string memory _arweaveCID) public {
        require(users[msg.sender].exists, "User not registered");
        videoCount++;
        videos[videoCount] = Video(videoCount, msg.sender, _arweaveCID, 0, 0);
        emit VideoUploaded(videoCount, msg.sender, _arweaveCID);
    }

    function likeVideo(uint256 _videoId) public {
        require(users[msg.sender].exists, "User not registered");
        require(_videoId > 0 && _videoId <= videoCount, "Invalid video ID");
        require(!userLikes[msg.sender][_videoId], "You have already liked this video");

        Video storage video = videos[_videoId];
        video.likes++;
        userLikes[msg.sender][_videoId] = true;

        emit VideoLiked(_videoId, msg.sender);
    }

    function addComment(uint256 _videoId, string memory _content) public {
        require(users[msg.sender].exists, "User not registered");
        require(_videoId > 0 && _videoId <= videoCount, "Invalid video ID");
        require(bytes(_content).length > 0, "Comment cannot be empty");

        commentCount++;
        Comment memory newComment = Comment(commentCount, _videoId, msg.sender, _content);
        videoComments[_videoId].push(newComment);

        videos[_videoId].commentCount++;

        emit CommentAdded(_videoId, commentCount, msg.sender);
    }

    function getVideo(uint256 _videoId) public view returns (Video memory) {
        require(_videoId > 0 && _videoId <= videoCount, "Invalid video ID");
        return videos[_videoId];
    }

    function getVideoComments(uint256 _videoId) public view returns (Comment[] memory) {
        require(_videoId > 0 && _videoId <= videoCount, "Invalid video ID");
        return videoComments[_videoId];
    }

    function getUser(address _userAddress) public view returns (User memory) {
        require(users[_userAddress].exists, "User not found");
        return users[_userAddress];
    }
}